//
//  Date+Extensions.swift
//  iHUD
//
//  Created by Sergey Monastyrskiy on 29.04.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
}
