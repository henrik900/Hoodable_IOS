//
//  SideMenuView.swift
//  ENEFrontend
//
//  Created by ASHWANI on 22/09/18.
//  Copyright © 2018 Gomes. All rights reserved.
//

import UIKit

extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate)
            .draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


class SideMenuView: UIView, UITableViewDelegate, UITableViewDataSource {
 
  
    var sideMenuArray = ["Home", "Profile", "Set Language", "Notification", "Logout"]
    
    
    @IBOutlet weak var sideTableView: UITableView!
    @IBOutlet weak var hideMenuButton: UIButton!
 
     //["Home", "Change Password", "Change Preferred Language", "App Guide", "FAQs","Contact Us","Log Out"]
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        let view = Bundle.main.loadNibNamed("SideMenuView", owner: self, options: nil)?[0] as? UIView
        view?.frame = frame
        addSubview(view!)
        
 
    }
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UITableView Delegates & Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "SideMenuCell"
        var cell: SideMenuCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? SideMenuCell
        
        if cell == nil {
            tableView.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SideMenuCell
        }
        if  nil == (UserDefaults.standard.value(forKey: "id") as? NSInteger) && indexPath.row == self.sideMenuArray.count-1
        {
            cell.cellTitleLabel.text! = "Login"
            
            
        }
        else if  nil == (UserDefaults.standard.value(forKey: "id") as? NSInteger) && indexPath.row == 1
        {
            cell.cellTitleLabel.text! = "Signup as Agent"
            
        }
        else
        {
            cell.cellTitleLabel.text! = self.sideMenuArray[indexPath.row]
            
        }
 
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        AppDelegate.instance().showSideMenu(value: false)
        AppDelegate.instance().onClickOfSideMenuOptons(indexNo: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewArray: [Any] = Bundle.main.loadNibNamed("SideMenuHeader", owner: self, options: nil)!
        let view: UIView? = (viewArray[0] as? UIView)
        let userImageView: UIImageView? = view?.viewWithTag(16011) as? UIImageView
        let userNameLabel: UILabel? = view?.viewWithTag(16012) as? UILabel
        let userEmailLabel: UILabel? = view?.viewWithTag(16013) as? UILabel
        userImageView?.layer.cornerRadius = 30
        userImageView?.layer.borderWidth = 2
        userImageView?.layer.borderColor = UIColor(red: 225/255, green: 41/255, blue: 85/255, alpha: 1.0).cgColor
        
        if  nil != (UserDefaults.standard.value(forKey: "id") as? NSInteger)
        {
            userNameLabel?.text =  UserDefaults.standard.value(forKey: "name") as! String
            userEmailLabel?.text =  UserDefaults.standard.value(forKey: "family") as! String
            
        }
        else
        {
            userNameLabel?.text =  "Guest User"
            userEmailLabel?.text =  " "
            
        }
      

        return view!
    }
    
  /*  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let viewArray: [Any] = Bundle.main.loadNibNamed("SideMenuFooter", owner: self, options: nil)!
        let view: UIView? = (viewArray[0] as? UIView)
        return view!
    }
    */
    @IBAction func hideButtonAction(_ sender: Any) {
        AppDelegate.instance().showSideMenu(value: false)
    }
}
