//
//  ServiceTableViewCell.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    // MARK: - Class functions
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
    
    
    // MARK: - Custom functions
    func setup(_ item: CD) {
        self.titleLabel.text = String(format: "%@ (%@)", item.title.uppercaseFirst, item.country.uppercased())
        self.artistLabel.text = String(format: "%@", item.artist)
        self.yearLabel.text = String(format: "%@", item.year)
    }
}
