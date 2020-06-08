//
//  Extensions.swift
//  GithubDemoApp
//
//  Created by Gagan joshi on 07/06/20.
//  Copyright © 2020 RahulSharma. All rights reserved.
//

import UIKit

extension UITableView{
    
    func registerCell(cellName : String ){
        self.register(UINib.init(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }
    
}

extension UIApplication {
    
 
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}


class Cache {

    static let shared = Cache()

    private let cache = NSCache<NSString, UIImage>()
    var task = URLSessionDataTask()
    var session = URLSession.shared

    func imageFor(url: URL, completionHandler: @escaping ( _ image: UIImage? , _ error: Error?) -> Void) {
            if let imageInCache = self.cache.object(forKey: url.absoluteString as NSString)  {
                completionHandler(imageInCache, nil)
                return
            }

            self.task = self.session.dataTask(with: url) { data, response, error in

                if error != nil {
                    completionHandler(nil, Error.self as? Error)
                    return
                }

                let image = UIImage(data: data!)

                self.cache.setObject(image!, forKey: url.absoluteString as NSString)
                    completionHandler(image, nil)
                }

            self.task.resume()
    }
}
