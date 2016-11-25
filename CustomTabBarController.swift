//
//  CustomTabBarController.swift
//  FoodRound
//
//  Created by Chang sean on 2016/10/18.
//  Copyright © 2016年 Chang sean. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.black
        self.tabBar.tintColor = UIColor.white
        
        let FavMainView = FavMainViewController()
        let FavMainNavi = UINavigationController(rootViewController: FavMainView)
        FavMainNavi.tabBarItem.title = "最愛"
        FavMainNavi.tabBarItem.image = UIImage(named: "favorite")
        
        let testView2 = UIViewController()
        let testNavi2 = UINavigationController(rootViewController: testView2)
        testNavi2.tabBarItem.title = "發現"
        testNavi2.tabBarItem.image = UIImage(named: "discover")
        
        let testView3 = UIViewController()
        let testNavi3 = UINavigationController(rootViewController: testView3)
        testNavi3.tabBarItem.title = "關於"
        testNavi3.tabBarItem.image = UIImage(named: "about")

        viewControllers = [FavMainNavi, testNavi2, testNavi3]
    }
}
