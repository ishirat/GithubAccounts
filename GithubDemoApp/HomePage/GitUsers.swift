//
//  GitUsers.swift
//  GithubDemoApp
//
//  Created by Gagan joshi on 06/06/20.
//  Copyright © 2020 RahulSharma. All rights reserved.
//

import Foundation

// MARK: - GitUsers

class GitUser {
    var login: String?
    var avatarURL: String?
    var url: String?
    var reposURL: String?
    var repoCount: Int?
    var isProfileDownloaded: Bool = false
    
    var email: String!
    var location: String!
    var joinDate: String!
    var followers: String!
    var following: String!
    
    var repos: [Repo]?
    var temp: [Repo]?
    
    init( data : [String : Any]) {
        if let login = data["login"] as? String{
            self.login = login
        }
        
        if let url = data["url"] as? String{
            self.url = url
        }
        
        if let repos_url = data["repos_url"] as? String{
            self.reposURL = repos_url
        }
        
        if let avatar_url = data["avatar_url"] as? String{
            self.avatarURL = avatar_url
        }
        
    }
    
    
    func updateUserDetails(data : [String : Any]){
        if let email = data["email"] as? String{
            self.email = email
        }else{
             self.email = "N/A"
        }
        
        if let following = data["following"] as? Int{
            self.following = "Following \(following)"
        }else{
            self.following = "Following 0"
        }
        
        if let followers = data["followers"] as? Int{
            self.followers = "\(followers) Followers"
        }else{
            self.following = "0 Followers"
        }
        
        if let location = data["location"] as? String{
            self.location = location
        }else{
            self.location = "N/A"
        }
        
        if let date = data["created_at"] as? String{
            
            let dateFormatter = DateFormatter()
            let tempLocale = dateFormatter.locale // save locale temporarily
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: date)!
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateFormatter.locale = tempLocale // reset the locale
            joinDate =  dateFormatter.string(from: date)
            
        }
    }
    
    func updateRepoInfo(data: [[String:Any]]){
        repos = [Repo]()
        for repo in data{
            repos?.append(Repo.init(data: repo))
        }
    }
    
    
    func seacrhRepos(qString: String){
        if qString.count > 0{
            if temp == nil{
                temp = repos
            }
            
            repos?.removeAll()
            
            let _temp = temp?.filter({
                ($0.repoName?.contains(qString))!
            })
            repos = _temp
            
        }else{
            repos?.removeAll()
            repos = temp
            temp = nil
        }
    }
}


class Repo{
    var repoName: String?
    var stars: String?
    var forks: String?
    
    init(data: [String: Any]) {
        
        if let name = data["name"] as? String{
            self.repoName = name
        }
        
        if let forks = data["forks"] as? Int{
            self.forks = "Forks - \(forks)"
        }else{
             self.forks = "Forks - 0"
        }
        
        if let stars = data["stargazers_count"] as? Int{
            self.stars = "Stars - \(stars)"
        }else{
             self.stars = "Forks - 0"
        }
    
    }
    
}
