//
//  UIViewController+Extensions.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(
        withTitle title: String = "info".localize(),
        withMessage message: String,
        withCancelTitle cancelTitle: String? = nil,
        andActionTitle actionTitle: String = "ok".localize(),
        withTimeWaiting waiting: TimeInterval = 30.0
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let cancel = cancelTitle {
            alert.addAction(UIAlertAction(title: cancel.localize(), style: .cancel, handler: nil))
        }
        
        alert.addAction(UIAlertAction(title: actionTitle.localize(), style: .default, handler: { _ in
            alert.message = nil
        }))
        
        present(alert, animated: true, completion: { Timer.scheduledTimer(withTimeInterval: waiting, repeats: false, block: { _ in
            guard alert.message != nil else { return }
            
            self.dismiss(animated: true, completion: {
                alert.message = nil
            })
        })})
    }
}
