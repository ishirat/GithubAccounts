//
//  Networking.swift
//  GithubDemoApp
//
//  Created by Gagan joshi on 06/06/20.
//  Copyright © 2020 RahulSharma. All rights reserved.
//

import Foundation

class Networking {
    
    func getAPICall(url: String, quderyItems : [URLQueryItem]? ,  completion: @escaping(_ success: Bool, _ data: [String: Any] ) -> Void ){
        
        AppUtilities.showPI(string: "")
        guard var urlComponents = URLComponents(string:url ) else { return }
       
        if let qItem = quderyItems{
             urlComponents.queryItems = qItem
        }
       
        
        if let url = urlComponents.url?.absoluteURL {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse,  let data = data{
                    do {
                        
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                            print(json)
                            switch httpResponse.statusCode  {
                            case 200:
                                completion(true, json)
                                break
                            default:
                                completion(false, json)
                                break
                            }
                            AppUtilities.hidePI()
                        }else if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]{
                            print(json)
                            let dict = ["dict": json]
                            switch httpResponse.statusCode  {
                            case 200:
                                completion(true, dict)
                                break
                            default:
                                completion(false, dict)
                                break
                            }
                             AppUtilities.hidePI()
                        }
                        
                    } catch let error {
                        
                        AppUtilities.showAlert(title: "GitHubdemo", message: error.localizedDescription)
                        AppUtilities.hidePI()
                    }
                }
            }.resume()
        }
    }
}
