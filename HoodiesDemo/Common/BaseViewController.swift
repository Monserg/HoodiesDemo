//
//  BaseViewController.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Class functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - Custom functions
    func setupTabBarItem() {
        let tabBarIndex = isKind(of: ListViewController.self) ? 0 : 1
        print("\(tabBarIndex)")
        
        self.view.backgroundColor = .white
        self.title = (tabBarIndex == 0 ? "list" : "service").localize()
        
        self.tabBarItem = UITabBarItem(title: (tabBarIndex == 0 ? "list" : "service").localize(),
                                       image: UIImage(named: tabBarIndex  == 0 ? "icon-list-default" : "icon-service-default"),
                                       selectedImage: UIImage(named: tabBarIndex == 0 ? "icon-list-selected" : "icon-service-selected"))
    }
}
