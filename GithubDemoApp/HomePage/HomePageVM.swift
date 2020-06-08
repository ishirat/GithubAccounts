//
//  HomePageVM.swift
//  GithubDemoApp
//
//  Created by Gagan joshi on 06/06/20.
//  Copyright © 2020 RahulSharma. All rights reserved.
//

import Foundation

class HomePageVM{
    
    var gitUsers: [GitUser]?
    var callBackForUIUpdte : ((Bool) -> Void)?
    let limit = 10
    var page = 1
    var qString = ""
    
    func getUserList( ){
        let network = Networking()
        let queryItems = [URLQueryItem(name: "q", value: qString),
                          URLQueryItem(name: "page", value: "\(page)"  ), URLQueryItem(name: "per_page", value: "10")]
        
        network.getAPICall(url: AppChangables.baseURL+AppChangables.users , quderyItems:queryItems) {  [weak self ] (status, data) in
            guard let self = self else { return }
            
            if status {
                if let dictCol = data["items"] as? [[String : Any]]{
                    if self.gitUsers == nil{
                        self.gitUsers = [GitUser]()
                        self.addDataInCollection(dictCol: dictCol)
                        
                    } else if self.gitUsers != nil{
                        self.addDataInCollection(dictCol: dictCol)
                    }
                }
            }
            self.callBackForUIUpdte?(status)
        }
    }
    
    func addDataInCollection( dictCol: [[String: Any]]){
        for item in dictCol{
            gitUsers?.append(GitUser.init(data: item))
        }
    }
    
}
