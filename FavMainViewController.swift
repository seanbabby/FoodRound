//
//  FavMainViewController.swift
//  FoodRound
//
//  Created by Chang sean on 2016/10/18.
//  Copyright © 2016年 Chang sean. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FavMainViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate {
    
    var searchBar: UISearchBar!
    var tableView: UITableView!
    
    var nametext:String = ""
    var mailtext:String = ""
    var imgURL:String   = ""
    
    var navi: UINavigationController!
    
    let height = UIScreen.main.bounds.height
    let width  = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        fetchProfile()
        setSearchBar()
        setTableView()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新增", style: .done, target: self, action: #selector(handleNew))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(handleLogOut))
    }
    
    func handleLogOut() {
        try! FIRAuth.auth()?.signOut()
        FBSDKLoginManager().logOut()
        dismiss(animated: true, completion: nil)
    }
    
    func handleNew() {
        let favNewVC = FavNewController()
        let favNewNC = UINavigationController(rootViewController: favNewVC)
    self.present(favNewNC, animated: true, completion: nil)
    }
    
    func setTableView() {
//        tableView = UITableView(frame: CGRect(x: 0, y: 100, width: width, height: height), style: .grouped)
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.white
//        tableView.register(<#T##aClass: AnyClass?##AnyClass?#>, forHeaderFooterViewReuseIdentifier: <#T##String#>)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        tableView.delegate = self
//        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -100).isActive = true
    }
    
    //設定組數
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //返回總共有多少cell筆數
    private func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
//    private func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        return
//    }
    
    func setSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 0,y: 0,width: width,height: 35)
        searchBar.layer.position = CGPoint(x: width * 0.5, y: 82)//(x: self.view.bounds.width / 2, y: 100)
        
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOpacity = 0.5
        searchBar.layer.masksToBounds = false
        
        searchBar.showsCancelButton = true
        
        searchBar.showsBookmarkButton = false
        
        searchBar.searchBarStyle = .default
        //set title
        //searchBar.prompt = "Search..."
        //set placeHolder
        searchBar.placeholder = "搜尋..."
        searchBar.tintColor = UIColor.black
        searchBar.showsSearchResultsButton = false
        
        self.view.addSubview(searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func fetchProfile(){
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start{ (connection, result, error) -> Void in
            
            if error != nil{
                print(error as Any)
                return
            }
            
            let dict = result! as! NSDictionary
            
            if let firstName = dict["first_name"] as? String, let lastName = dict["last_name"] as? String {
                self.nametext = "\(firstName) \(lastName)"
                self.navigationItem.title = self.nametext
            }
            
            if let email = dict["email"] as? String {
                self.mailtext = email
            }
            
            if let picture = dict["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String {
                self.imgURL = url
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}


