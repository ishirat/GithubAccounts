//
//  ViewController.swift
//  GithubDemoApp
//
//  Created by Gagan joshi on 06/06/20.
//  Copyright © 2020 RahulSharma. All rights reserved.
//

import UIKit

class HomePage: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    let homeVM = HomePageVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell(cellName: String.init(describing: ListCell.self))
        setInitView()
        homeVM.callBackForUIUpdte = updateUI
       
    }
    
    private func setInitView(){
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 0
        tableView.layer.borderWidth = 1.5
        tableView.layer.borderColor = UIColor.gray.cgColor
    }
    
    func updateUI(val : Bool){
        DispatchQueue.main.async {
            if val{
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func changeTextValue(_ sender: UITextField) {
        if let text = sender.text , text.count > 0 {
            homeVM.gitUsers = nil
            homeVM.qString = text
            homeVM.getUserList()
        }else{
            homeVM.gitUsers = nil
            homeVM.page = 1
            self.tableView.reloadData()
        }
    }
    
}

extension HomePage : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let gitUser = homeVM.gitUsers , gitUser.count > 0{
            return  gitUser.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ListCell.self), for: indexPath) as? ListCell , let gitUsers = homeVM.gitUsers{
           
            let gitUser = gitUsers[indexPath.row]
            
            cell.setDataToCell(user: gitUser)
            
            return cell
        }
        return UITableViewCell()
        
    }
  

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let gitUsers = homeVM.gitUsers  {
            openUserDetailView(gitUser: gitUsers[indexPath.row])
        }
    }

    private func openUserDetailView( gitUser: GitUser){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserProfile") as? UserProfile{
            vc.userProfileVM.profile = gitUser
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let gitUsers = homeVM.gitUsers, indexPath.row == gitUsers.count - 2 && gitUsers.count > 0 {
            homeVM.page += 1
            homeVM.getUserList()
        }
    }
    
}



