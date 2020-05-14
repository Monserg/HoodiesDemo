//
//  NameViewController.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

enum ModeType {
    case add
    case edit
}

class NameViewController: UIViewController {
    // MARK: - Properties
    var mode: ModeType
    
    
    // MARK: - Initialization
    init(modeType: ModeType = .add) {
        self.mode = modeType
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Class functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    
    // MARK: - custom functions
    private func setupView() {
        self.title = (self.mode == .add ? "add" : "edit").localize()
    }
}
