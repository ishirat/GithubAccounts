//
//  UserProfileVM.swift
//  GithubDemoApp
//
//  Created by Gagan joshi on 07/06/20.
//  Copyright © 2020 RahulSharma. All rights reserved.
//

import UIKit

class UserProfileVM{
    
    var callBackForUIUpdte : ((Bool) -> Void)?
    var profile : GitUser?
    
    
    func registerCell(tableview: UITableView){
        tableview.registerCell(cellName: "UserDetailsCell")
        tableview.registerCell(cellName: "RepoInfoCell")
        
    }
    
    func getUserProfile(){
    
        
        let dispatchGroup = DispatchGroup() // creating dispatch group
        dispatchGroup.enter()
        
        // call user API
        if let url = profile?.url{
            let network = Networking()
            network.getAPICall(url: url, quderyItems: nil) { [weak self] (status, data) in
                guard let self = self else { return }
                if status{
                    self.profile?.updateUserDetails(data: data)
                    dispatchGroup.leave()
                }
            }
        }
        
        
        dispatchGroup.enter()
        // call user repo api 
        if let url = profile?.reposURL{
            let network = Networking()
            network.getAPICall(url: url, quderyItems: nil) {  (status, data) in
                if let items = data["dict"] as? [[String: Any]] , status{
                    self.profile?.updateRepoInfo(data: items)
                    dispatchGroup.leave()
                }
            }
        }
        

        dispatchGroup.notify(queue: .main) {
            self.callBackForUIUpdte?(true)
            print("Both functions complete 👍")
        }
    
    }

}
