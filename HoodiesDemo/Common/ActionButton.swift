//
//  BaseButton.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    // MARK: - Properties
    private var actionHandler: (() -> Void)?
    
    
    // MARK: - Initialization
    convenience init(frame: CGRect, title: String, titleColor: UIColor, borderColor: UIColor = .blue, actionHandler: @escaping (() -> Void)) {
        self.init(frame: frame)
        
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title.localize(), for: .normal)
        self.titleEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        self.actionHandler = actionHandler
        
        layer.cornerRadius = 8.0
        layer.borderWidth = 2.0
        layer.borderColor = borderColor.cgColor
        
        self.clipsToBounds = true
        self.layoutIfNeeded()
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    
    // MARK: - Actions
    @objc func buttonTapped(_ sender: UIButton) {
        if let actionHandler = self.actionHandler {
            actionHandler()
        }
    }
    
}
