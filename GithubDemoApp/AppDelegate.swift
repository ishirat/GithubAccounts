//
//  AppDelegate.swift
//  GithubDemoApp
//
//  Created by Gagan joshi on 06/06/20.
//  Copyright © 2020 RahulSharma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomePage") as? HomePage else {
            return false 
        }
        let navigationController = UINavigationController(rootViewController: rootVC)

        navigationController.navigationBar.isHidden = true
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        return true
    }

}

