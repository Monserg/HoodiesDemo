//
//  String+Extensions.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

extension String {
    var first: String { String(prefix(1)) }
    var uppercaseFirst: String { first.uppercased() + String(dropFirst()) }

    func localize() -> String {
        return NSLocalizedString(self, comment: "").uppercaseFirst
    }
}
