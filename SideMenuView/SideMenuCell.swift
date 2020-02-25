//
//  SideMenuCell.swift
//  ENEFrontend
//
//  Created by ASHWANI on 22/09/18.
//  Copyright © 2018 Gomes. All rights reserved.
//


import UIKit

class SideMenuCell: UITableViewCell {
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellTitleImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
