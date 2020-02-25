//
//  SearchCollectionViewCell.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 13/02/20.
//  Copyright © 2020 Rustam Atabaev. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var endLbl: UILabel!
    @IBOutlet weak var openLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var phoneBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.phoneBtn.setFAIcon(icon: .FAPhone, iconSize: 30, forState: .normal)

        // Initialization code
    }

}
