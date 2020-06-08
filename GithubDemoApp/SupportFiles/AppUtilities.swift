//
//  AppUtilities.swift
//  WeatherReport
//
//  Created by Rahul Sharma on 16/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import UIKit
class AppUtilities{
    
    class func showAlert(title:String, message:String  , okButtonAction: (()->Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            okButtonAction?()
        }
        alert.addAction(okButton)
        alert.view.tintColor = #colorLiteral(red: 0.02352941176, green: 0.2, blue: 0.4117647059, alpha: 1)
        UIApplication.getTopMostViewController()?.present(alert, animated: true, completion: nil)
    }
    
    class func showPI(string:String) {
        DispatchQueue.main.async {
            let progress: LoadingProgress = LoadingProgress.shared
            progress.showPI(message: string)
        }
        
    }
    class func hidePI(){
         DispatchQueue.main.async {
            LoadingProgress.shared._hide()
        }
    }
    
    
}
