//
//  LogInViewController.swift
//  FoodRound
//
//  Created by Chang sean on 2016/10/19.
//  Copyright © 2016年 Chang sean. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var window:UIWindow?
    
    var onLogin = UILabel()
    
    var indicator:UIActivityIndicatorView?
    
    let FBLogInBT:FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.readPermissions = ["email"]
        return button
    }()
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.setupLoginBT()
        self.setOnLoginningLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if FIRAuth.auth()?.currentUser?.uid != nil {
            print("uid : ", FIRAuth.auth()?.currentUser?.uid as Any)
            self.onLogin.isHidden = false
            setupIndicator()
            
            DispatchQueue.main.async {
                self.indicator?.stopAnimating()
                self.present(CustomTabBarController(), animated: true, completion: nil)
            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
//                
//                self.indicator?.stopAnimating()
//                
//                self.present(CustomTabBarController(), animated: true, completion: nil)
//            }
        } else {
            self.onLogin.isHidden = true
        }
    }
    
    func setupIndicator() {
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        self.indicator?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(indicator!)
        self.indicator?.startAnimating()
        
        self.indicator?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.indicator?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.indicator?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.indicator?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setOnLoginningLabel() {
        onLogin = UILabel()
        onLogin.isHidden = true
        onLogin.translatesAutoresizingMaskIntoConstraints = false
        onLogin.textAlignment = .center
        onLogin.textColor = UIColor.white
        onLogin.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 0.9)
        onLogin.clipsToBounds = true
        onLogin.layer.cornerRadius = (height*0.2)/10
        onLogin.text = "登入中   請稍候"
        self.view.addSubview(onLogin)
        
        onLogin.widthAnchor.constraint(equalToConstant: width * 0.7).isActive = true
        onLogin.heightAnchor.constraint(equalToConstant: height * 0.08).isActive = true
        onLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        onLogin.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupLoginBT() {
        FBLogInBT.delegate = self
        FBLogInBT.clipsToBounds = true
        FBLogInBT.layer.cornerRadius = (height*0.2)/10
        view.addSubview(FBLogInBT)
        
        FBLogInBT.widthAnchor.constraint(equalToConstant: width * 0.7).isActive = true
        FBLogInBT.heightAnchor.constraint(equalToConstant: height * 0.08).isActive = true
        FBLogInBT.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        FBLogInBT.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            print(error!.localizedDescription)
            return
        }
        
        self.onLogin.isHidden = false
        self.setupIndicator()
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.indicator?.stopAnimating()
                self.present(CustomTabBarController(), animated: true, completion: nil)
                print("user logged in with Facebook")
            }
        })
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        try! FIRAuth.auth()?.signOut()
        print("User logged out of Facebook")
    }

}
