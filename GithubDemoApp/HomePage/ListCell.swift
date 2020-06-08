//
//  ListCell.swift
//  GithubDemoApp
//
//  Created by Gagan joshi on 06/06/20.
//  Copyright © 2020 RahulSharma. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var repoCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setDataToCell(user: GitUser){
        userName.text = user.login ?? "N/A"
        if let url = URL.init(string: user.avatarURL ?? ""){
            Cache.shared.imageFor(url: url, completionHandler: { (image, error) in
                if error == nil{
                    DispatchQueue.main.async {
                         self.profilePic.image = image
                    }
                }
            })
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
