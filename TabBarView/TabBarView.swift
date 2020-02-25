//
//  TabBarView.swift
//  SGDoc
//
//  Created by Spicejet LTD on 22/01/20.
//  Copyright © 2020 Spicejet LTD. All rights reserved.
//

import UIKit


class TabBarView: UIView {
    
    //All Tab Bar Varibales
    
    var transparenBgView = UIView()
    var mainView = UIView()
    @IBOutlet weak var tabBarBgView: UIView!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
       
        btn1.setFAIcon(icon: .FAUserO, iconSize: 30, forState: .normal)
        btn2.setFAIcon(icon: .FABellO, iconSize: 30, forState: .normal)
        btn3.setFAIcon(icon: .FAPlus, iconSize: 30, forState: .normal)
        btn4.setFAIcon(icon: .FASearch, iconSize: 30, forState: .normal)
        btn5.setFAIcon(icon: .FAAngleRight, iconSize: 40, forState: .normal)
        btn3.layer.cornerRadius = 32
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TabBarView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func passDataToControler(str:String) {
        let controller_name:[String: Any] = ["controlleraName": str]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil, userInfo: controller_name)
    }
    
    // MARK: - All Tab Bar Button Action
    @IBAction func firstBtnAction(_ sender: Any) {
        passDataToControler(str: "HomeVC")
        
    }
    @IBAction func secondBtnAction(_ sender: Any) {
        passDataToControler(str: "NotificationVC")

    }
    @IBAction func thirdBtnAction(_ sender: Any) {
        passDataToControler(str: "DashBoardVC")

    }
    
    
    @IBAction func fourBtnAction(_ sender: Any) {
        passDataToControler(str: "SearchVC")

    }
    @IBAction func fifthBtnAction(_ sender: Any) {
        passDataToControler(str: "SideMenuVC")

    }
    
    func showAlert(message: String, title: String? = "Alert!") {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message:"Comming Soon", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: AlertConstants.OK, style: UIAlertAction.Style.default, handler: nil))
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}


