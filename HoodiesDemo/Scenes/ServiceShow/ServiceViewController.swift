//
//  ViewController.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

class ServiceViewController: BaseViewController {
    // MARK: - Properties
    var dispatchWorkItem: DispatchWorkItem!
    let queue = DispatchQueue.global(qos: .userInitiated)
    
    
    // MARK: - Class functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.stop()
        print("cancel")
        dispatchWorkItem.cancel()
    }

    
    // MARK: - Custom functions
    private func loadData() {
        self.start()
        
        self.dispatchWorkItem = DispatchWorkItem {
            if let url = URL(string: "https://www.w3schools.com/xml/cd_catalog.xml"), let parser = ParserManager(contentsOf: url) {
                parser.completed = { catalog in
                    self.stop()
                }
                
                parser.delegate = parser
                parser.parse()
            }
        }

        self.queue.async(execute: self.dispatchWorkItem)
    }
}
