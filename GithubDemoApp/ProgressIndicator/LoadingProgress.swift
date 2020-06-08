//
//  LoadingProgress.swift
//  Channel 40
//
//  Created by STARK on 04/02/17.
//  Copyright © 2017 Nabeel Gulzar. All rights reserved.
//

import UIKit

class LoadingProgress: UIView {
    
    @IBOutlet weak var progressImage: UIImageView!
    
    private static var obj: LoadingProgress? = nil
    static var flagClose    = false
    
    static var shared: LoadingProgress {
        if obj == nil {
            obj = UINib(nibName: "LoadingProgress", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as? LoadingProgress
            obj?.frame = UIScreen.main.bounds
        }
        return obj!
    }
    
    @IBOutlet weak var loadingHead: UILabel!
    
    private func setup() {
        DispatchQueue.main.async {
            let window:UIWindow = UIApplication.shared.delegate!.window!!
            window.windowLevel = UIWindow.Level.alert
            window.addSubview(self)
            self.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0)
            
            UIView.animate(withDuration: 0.01, delay: 0.01, options: .beginFromCurrentState, animations: {() -> Void in
                self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            }, completion: {(_ finished: Bool) -> Void in
            })
        }
       
        
       
    }
    
    func showPI(message: String) {
        setup()
      
        DispatchQueue.main.async {
            self.loadingHead.text = message
            let jeremyGif = UIImage.gifImageWithName("loading_orange1")
            self.progressImage.image = jeremyGif
        }
    
        let when = DispatchTime.now() + 30
        DispatchQueue.main.asyncAfter(deadline: when){
            self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            UIView.animate(withDuration: 0.01, delay: 0.01, options: .beginFromCurrentState, animations: {() -> Void in
                self.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0)
            }, completion: {(_ finished: Bool) -> Void in
                if (LoadingProgress.obj != nil) {
                    self.removeFromSuperview()
                }
            })
        }
    }
    
    func _hide() {
        if (LoadingProgress.obj != nil) {
            DispatchQueue.main.async {
                 self.removeFromSuperview()
            }
           
        }
    }
    
    
    func setLabel(text:String) {
        loadingHead.text = text
    }
}
