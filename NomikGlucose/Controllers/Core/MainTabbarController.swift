//
//  MainTabbarController.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/27.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = HomeViewController()
        let vc2 = ListViewController()
        
        vc2.title = "血糖清單"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        nav2.navigationBar.prefersLargeTitles = true
        nav2.tabBarItem.title = ""
        
        nav1.tabBarItem.image = UIImage(systemName: "waveform.path.ecg.rectangle")
        nav2.tabBarItem.image = UIImage(systemName: "cross.case")
        
        setViewControllers([nav1, nav2], animated: true)
    }
}
