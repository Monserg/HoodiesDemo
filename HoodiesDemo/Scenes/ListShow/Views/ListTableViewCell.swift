//
//  ListTableViewCell.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    // MARK: - Properties
    var item: Item!
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemStatusButton: UIButton!

    @IBOutlet weak var itemImageView: UIImageView! {
        didSet {
            itemImageView.layer.cornerRadius = itemImageView.frame.height / 2
            itemImageView.clipsToBounds = true
        }
    }
        
    
    // MARK: - Class functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Custom functions
    func setup(withItem item: Item) {
        self.item = item
        
        self.itemStatusButton.isSelected = item.isChecked
        self.itemNameLabel.text = item.name
        self.setImage()
    }
    
    private func setImage() {
        self.itemImageView.image = UIImage(named: item.isChecked ? "icon-ok-green" : "icon-cancel-red")
    }
    
    
    // MARK: - Actions
    @IBAction func statusButtonTapped(_ sender: UIButton) {
        sender.isSelected  = !sender.isSelected
        self.setImage()
       
        // Save to Realm
        
    }
}
