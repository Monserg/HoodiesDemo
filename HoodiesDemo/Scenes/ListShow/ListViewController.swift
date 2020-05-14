//
//  ListViewController.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController {
    // MARK: - Properties
    
    
    // MARK: - Class functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
        
    
    // MARK: - Custom functions
    private func setupView() {
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                                                  target: self,
                                                                  action: #selector(addButttonTapped))

        
    }
    
    
    // MARK: - Actions
    @objc func addButttonTapped(_ sender: UIBarButtonItem) {
        Logger.log(message: "run", event: .debug)
        self.show(NameViewController(), sender: nil)
    }
}
