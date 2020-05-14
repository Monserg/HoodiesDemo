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
    var catalog: [CD]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = false
            }
        }
    }
    
    var dispatchWorkItem: DispatchWorkItem!
    let queue = DispatchQueue.global(qos: .userInitiated)
    let tableView: UITableView = UITableView()
    

    // MARK: - Class functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupView()
        loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Logger.log(message: "dispatchWorkItem.cancel", event: .debug)

        super.viewDidDisappear(animated)
        
        self.stop()
        self.catalog = nil
        dispatchWorkItem.cancel()
    }

    
    // MARK: - Custom functions
    private func loadData() {
        self.start()
        
        self.dispatchWorkItem = DispatchWorkItem {
            if let url = URL(string: "https://www.w3schools.com/xml/cd_catalog.xml"), let parser = ParserManager(contentsOf: url) {
                parser.completed = { catalog in
                    self.stop()
                    self.catalog = catalog
                    Logger.log(message: "spinner.stop", event: .debug)
                }
                
                parser.delegate = parser
                parser.parse()
            }
        }

        self.queue.async(execute: self.dispatchWorkItem)
    }
    
    func setupView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "ServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "ServiceTableViewCell")

        guard let tabBar = (self.tabBarController as? MainTabBarController)?.tabBar else { return }
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: -tabBar.frame.height)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.isHidden = true
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
    }
}


// MARK: - UITableViewDataSource
extension ServiceViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard self.catalog?.count ?? 0 > 0 else { return 0 }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.catalog?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemCD = self.catalog?[indexPath.row] else { return UITableViewCell() }
            
        guard let serviceCell = tableView.dequeueReusableCell(withIdentifier: "ServiceTableViewCell", for: indexPath) as? ServiceTableViewCell else { return UITableViewCell() }
        
        serviceCell.setup(itemCD)
        
        return serviceCell
    }
}


// MARK: - UITableViewDelegate
extension ServiceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
}
