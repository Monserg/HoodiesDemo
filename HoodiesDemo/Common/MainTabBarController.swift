//
//  MainTabBar.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    // MARK: - Class functions
    override func viewDidLoad() {
        super.viewDidLoad()

//        tabBar.backgroundColor = .white
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        let listVC = ListViewController()
        let serviceVC = ServiceViewController()
        
        let controllers = [listVC, serviceVC]
        self.viewControllers = controllers
    }
}


// MARK: - UITabBarControllerDelegate
extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true
    }
}
