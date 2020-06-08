//
//  RepoInfoCell.swift
//  GithubDemoApp
//
//  Created by Gagan joshi on 08/06/20.
//  Copyright © 2020 RahulSharma. All rights reserved.
//

import UIKit

class RepoInfoCell: UITableViewCell {
    @IBOutlet weak var forkRepos: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    
    @IBOutlet weak var repoName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setDataToCell(repo: Repo){
        if let fork = repo.forks{
            forkRepos.text  = fork
        }
        
        if let name = repo.repoName{
            repoName.text = name
        }
        
        if let stars = repo.stars{
            starsCount.text = stars
        }
    }
    
}
