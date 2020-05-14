//
//  ViewController.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

class ServiceViewController: BaseViewController {
    // MARK: - Class functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    
    // MARK: - Custom functions
    private func loadData() {
        if let url = URL(string: "https://www.w3schools.com/xml/cd_catalog.xml"), let parser = ParserManager(contentsOf: url) {
            parser.delegate = parser
            parser.parse()
        }
    }
}
