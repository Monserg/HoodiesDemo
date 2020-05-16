//
//  ListViewController.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: BaseViewController {
    // MARK: - Properties
    var items: Results<Item>!
    let realmManager = RealmManager()
    let tableView: UITableView = UITableView()
        
    
    // MARK: - Class functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupView()
        self.items = self.realmManager.loadItems()
        self.tableView.reloadData()
        
        Logger.log(message: Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "XXX", event: .debug)
    }
    
    
    // MARK: - Custom functions
    private func setupView() {
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                                                  target: self,
                                                                  action: #selector(addButttonTapped))

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")

        guard let tabBar = (self.tabBarController as? MainTabBarController)?.tabBar else { return }
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: -tabBar.frame.height)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.showsVerticalScrollIndicator = false
    }
    
    
    // MARK: - Actions
    @objc func addButttonTapped(_ sender: UIBarButtonItem) {
        Logger.log(message: "run", event: .debug)
        self.show(NameViewController(), sender: nil)
    }
}


// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
                
        let item = self.items[indexPath.row]
        listCell.setup(withItem: item)
        
        listCell.checkComplete = { isSelected in
            self.realmManager.updateItem(oldName: item.name, newName: item.name, isChecked: isSelected, complete: {
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            })
        }
        
        return listCell
    }
}


// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.show(NameViewController(modeType: .edit, item: self.items[indexPath.row]), sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let menuEditButton = UITableViewRowAction(style: .normal, title: "edit".localize()) { action, index in
            self.show(NameViewController(modeType: .edit, item: self.items[editActionsForRowAt.row]), sender: nil)
        }
        
        menuEditButton.backgroundColor = .orange

        let menuDeleteButton = UITableViewRowAction(style: .normal, title: "delete".localize()) { action, index in
            // Realm
            let item = self.items[editActionsForRowAt.row]
            
            self.realmManager.delete(item: item)
            self.tableView.deleteRows(at: [editActionsForRowAt], with: .fade)
        }
        
        menuDeleteButton.backgroundColor = .blue

        return [menuDeleteButton, menuEditButton]
    }
}
