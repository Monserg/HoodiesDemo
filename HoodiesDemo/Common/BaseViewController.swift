//
//  BaseViewController.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Properties
    let spinner = Spinner(style: UIActivityIndicatorView.Style.gray)
    
    var whiteView: UIView {
        let whiteViewInstance = UIView()
        whiteViewInstance.frame = view.frame
        whiteViewInstance.backgroundColor = .yellow
        
        return whiteViewInstance
    }

    
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
        Logger.log(message: "tabBarIndex = \(tabBarIndex)", event: .debug)
        
        self.view.backgroundColor = .white
        self.title = (tabBarIndex == 0 ? "list" : "service").localize()
        
        self.tabBarItem = UITabBarItem(title: (tabBarIndex == 0 ? "list" : "service").localize(),
                                       image: UIImage(named: tabBarIndex  == 0 ? "icon-list-default" : "icon-service-default"),
                                       selectedImage: UIImage(named: tabBarIndex == 0 ? "icon-list-selected" : "icon-service-selected"))
    }
    
    func start() {
        DispatchQueue.main.async {
            self.view.addSubview(self.spinner)
            self.spinner.center = self.view.center
            self.spinner.startAnimating()
        }
    }
    
    func stop() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        self.spinner.removeFromSuperview()
        }
    }
}
