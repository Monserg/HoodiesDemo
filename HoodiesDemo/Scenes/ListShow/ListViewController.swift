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
    let tableView: UITableView = UITableView()

    var items: [String]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = false
            }
        }
    }

    
    // MARK: - Class functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupView()
        loadData()
    }
    
    
    // MARK: - Custom functions
    private func loadData() {
        self.items = ["ssssss ....", "ddd XXX"]
//        self.tableView.reloadData()
    }
    
    private func setupView() {
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                                                  target: self,
                                                                  action: #selector(addButttonTapped))

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        guard let tabBar = (self.tabBarController as? MainTabBarController)?.tabBar else { return }
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: -tabBar.frame.height)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.isHidden = true
//        tableView.allowsSelection = false
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
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = self.items?[indexPath.row] else { return UITableViewCell() }
            
        var listCell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        if( !(listCell != nil)) {
            listCell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        
        
        listCell!.setup(withItem: item)
        
        return listCell!
    }
}


// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
        
            switch cell.accessoryType {
            case .checkmark:
                cell.accessoryType = .none

            default:
                cell.accessoryType = .checkmark
            }

            // Save to Realm
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let menuEditButton = UITableViewRowAction(style: .normal, title: "edit".localize()) { action, index in
            self.show(NameViewController(modeType: .edit, item: Item(id: 1, name: "sergo", isChecked: true)), sender: nil)
        }
        
        menuEditButton.backgroundColor = .orange

        let menuDeleteButton = UITableViewRowAction(style: .normal, title: "delete".localize()) { action, index in
            self.items?.remove(at: editActionsForRowAt.row)

            tableView.beginUpdates()
            tableView.deleteRows(at: [editActionsForRowAt], with: .left)
            
//            if self.items?.count == 0 {
//                self.items = nil
//            }
            
            tableView.endUpdates()

//            self.tableView.deleteRows(at: [editActionsForRowAt], with: .left)

            // Delete item in Realm
            
        }
        
        menuDeleteButton.backgroundColor = .blue

        return [menuDeleteButton, menuEditButton]
    }
}
