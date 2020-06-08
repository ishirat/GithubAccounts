//
//  UserProfile.swift
//  GithubDemoApp
//
//  Created by Gagan joshi on 07/06/20.
//  Copyright © 2020 RahulSharma. All rights reserved.
//

import UIKit

class UserProfile: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let userProfileVM = UserProfileVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitView()
        userProfileVM.callBackForUIUpdte = updateUI
        userProfileVM.getUserProfile()
    }
    
    // MARK:- init setup for tableview
    private func setInitView(){
        userProfileVM.registerCell(tableview: tableView)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100;
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    /// used to update the UI after calling api , passing to closure
    /// - Parameter val: Bool value , pass the api success or failed status
    func updateUI(val : Bool){
        DispatchQueue.main.async {
            if val{
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func pressedBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- tableview
// tableView delegate and dataSocurce methods

extension UserProfile : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repos = userProfileVM.profile?.repos, repos.count > 0{
            return repos.count
        }
        return 0
    }
    
    // rows 
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RepoInfoCell", for: indexPath) as? RepoInfoCell, let repos = userProfileVM.profile?.repos {
            cell.setDataToCell(repo: repos[indexPath.row])
            return cell
        }
        return UITableViewCell()
    
    }
    
    // header
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        if  let headerCell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsCell") as? UserDetailsCell, let profile = userProfileVM.profile{
            headerCell.configure(data:profile )
            headerCell.delegate = self
            headerCell.backgroundColor = .white
            return headerCell
        }
        return UIView()
    }
}

//MARK:- UserDetailsDelegate
extension UserProfile: UserDetailsDelegate{
    
    
    /// method used to find the repos using qString
    /// - Parameter text: string name of repo
    func findRepo(text: String) {
       userProfileVM.profile?.seacrhRepos(qString: text)
            tableView.reloadData()
        
    }
}
