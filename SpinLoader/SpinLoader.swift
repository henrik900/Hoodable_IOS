//
//  SpinLoader.swift
//  ENEFrontend
//
//  Created by Gautam Shrivastav on 8/22/17.
//  Copyright © 2017 Gomes. All rights reserved.
//

import UIKit

class SpinLoader: UIView {

    @IBOutlet weak var spinLoaderBGView: UIView?
    @IBOutlet weak var spinLoaderImageView: UIImageView?
    
    var loaderImageArray = [UIImage]()

//    @IBOutlet weak var activityIndiactor: UIActivityIndicatorView!
//    @IBOutlet weak var loaderLabel: UILabel!
//    @IBOutlet weak var view: UIView!

//    class func instanceFromNib() -> UIView {
//        return UINib(nibName: "SpinLoader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
//    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        let view = Bundle.main.loadNibNamed("SpinLoader", owner: self, options: nil)?[0] as? UIView
        view?.frame = frame
        addSubview(view!)
        
        self.spinLoaderBGView?.layer.masksToBounds = true
        self.spinLoaderBGView?.layer.cornerRadius = 15.0
        setLoaderImages()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    func setLoaderImages() {
        loaderImageArray = [UIImage(named: "loader_0.png")!, UIImage(named: "loader_1.png")!, UIImage(named: "loader_2.png")!, UIImage(named: "loader_3.png")!, UIImage(named: "loader_4.png")!, UIImage(named: "loader_5.png")!, UIImage(named: "loader_6.png")!, UIImage(named: "loader_7.png")!, UIImage(named: "loader_8.png")!, UIImage(named: "loader_9.png")!, UIImage(named: "loader_10.png")!, UIImage(named: "loader_11.png")!, UIImage(named: "loader_12.png")!, UIImage(named: "loader_13.png")!, UIImage(named: "loader_14.png")!, UIImage(named: "loader_15.png")!, UIImage(named: "loader_16.png")!, UIImage(named: "loader_17.png")!, UIImage(named: "loader_18.png")!, UIImage(named: "loader_19.png")!, UIImage(named: "loader_20.png")!, UIImage(named: "loader_21.png")!, UIImage(named: "loader_22.png")!, UIImage(named: "loader_23.png")!, UIImage(named: "loader_24.png")!, UIImage(named: "loader_25.png")!, UIImage(named: "loader_26.png")!, UIImage(named: "loader_27.png")!, UIImage(named: "loader_28.png")!, UIImage(named: "loader_29.png")!]
        self.spinLoaderImageView?.animationImages = loaderImageArray
        self.spinLoaderImageView?.animationDuration = 1.0
        self.spinLoaderImageView?.animationRepeatCount = 0
        self.spinLoaderImageView?.startAnimating()
    }

}
