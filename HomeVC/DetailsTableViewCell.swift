//
//  DetailsTableViewCell.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 16/02/20.
//  Copyright © 2020 Rustam Atabaev. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var endLbl: UILabel!
    @IBOutlet weak var openLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var phoneBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
 
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
