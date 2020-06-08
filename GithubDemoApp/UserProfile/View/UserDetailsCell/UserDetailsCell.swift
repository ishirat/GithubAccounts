//
//  UserDetailsCell.swift
//  GithubDemoApp
//
//  Created by Gagan joshi on 08/06/20.
//  Copyright © 2020 RahulSharma. All rights reserved.
//

import UIKit

protocol UserDetailsDelegate: class {
    func findRepo(text: String)
}

class UserDetailsCell: UITableViewCell {

    weak var delegate: UserDetailsDelegate?
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var joinDate: UILabel!
    
    @IBOutlet weak var followers: UILabel!
    
    @IBOutlet weak var following: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(data: GitUser) {
        
        userName.text = data.login ?? ""
        email.text = data.email
        location.text = data.location
        joinDate.text = data.joinDate
        followers.text = data.followers
        following.text = data.following
        
        if let url = URL.init(string: data.avatarURL ?? ""){
            Cache.shared.imageFor(url: url, completionHandler: { (image, error) in
                if error == nil{
                    DispatchQueue.main.async {
                        self.userImage.image = image
                    }
                }
            })
        }
    }
    
    @IBAction func chnageTextWithValue(_ sender: UITextField) {
        if let text = sender.text , text.count > 0{
            delegate?.findRepo(text: text)
        }
    }

}
