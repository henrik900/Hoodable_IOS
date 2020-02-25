//
//  SpotDetailViewController.swift
//  Hoodable
//
//  Created by Gautam Gupta on 05/02/20.
//  Copyright © 2020 Gautam Gupta. All rights reserved.
//

import UIKit
import SDWebImage


class SpotDetailViewController: UIViewController,KYButtonDelegate {
    @IBOutlet weak var tbl_spot_details: UITableView!
    @IBOutlet weak var nameLbl: UILabel!

    @IBOutlet weak var mobileNo_Label: UILabel!
    @IBOutlet weak var bannerImg: UIImageView!
    
    @IBOutlet weak var phoneImg: UIImageView!
    @IBOutlet weak var webImg: UIImageView!
    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var timeImg: UIImageView!
    @IBOutlet weak var detailImg: UIImageView!
    var eventListArray = Array<Any>()
    
    var eventArray = Array<Any>()
    
    var compoListArray = Array<Any>()
    var promoListArray = Array<Any>()
    var localListArray = Array<Any>()

    var collapaseHandlerArray = [String]()


    let section = ["Events", "Competitions", "Promotions"]

    @IBOutlet weak var followBtn: UIButton!

    @IBOutlet weak var link_Btn: UIButton!
    
    @IBOutlet weak var rating_Label: UILabel!
    @IBOutlet weak var date_Label: UILabel!
    @IBOutlet weak var desc_Label: UILabel!

    var eventTypeString = NSString()

    var spotDetailDict = NSDictionary()
    @IBOutlet weak var button: KYButton!

    
    func callThisForValidation()  {
        
        
        button.kyDelegate = self
        button.openType = .popUp
        button.plusColor = UIColor.white
        button.fabTitleColor = UIColor.white
        followBtn.layer.cornerRadius = 4

        phoneImg.setFAIconWithName(icon: .FAPhone, textColor: .darkGray)
        webImg.setFAIconWithName(icon: .FAGlobe, textColor: .darkGray)
        timeImg.setFAIconWithName(icon: .FACalendar, textColor: .darkGray)
        starImg.setFAIconWithName(icon: .FAStar, textColor: .darkGray)
 
        //   btn1.setFAIcon(icon: .FAUserO, iconSize: 30, forState: .normal)
        
        button.add(color:UIColor.clear, title: "New Event", image: UIImage(named: "256-512.png")!){ (KYButtonCells) in
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "AddEventViewController") as! AddEventViewController
            viewController.idString = self.spotDetailDict.value(forKey: "id") as! NSInteger
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        button.add(color: UIColor.clear, title: "New Competition", image: UIImage(named: "256-512.png")!){ (KYButtonCells) in
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "CompititionViewController") as! CompititionViewController
            viewController.idString = self.spotDetailDict.value(forKey: "id") as! NSInteger
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        button.add(color: UIColor.clear, title: "New Promotion", image: UIImage(named: "256-512.png")!){ (KYButtonCells) in
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PromotionViewController") as! PromotionViewController
            viewController.idString = self.spotDetailDict.value(forKey: "id") as! NSInteger
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tbl_spot_details.tableFooterView = UIView()
        
        //Registering cell of header
        self.tbl_spot_details.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        
        //Setting Delegate and datasource for Table
        tbl_spot_details.delegate = self
        tbl_spot_details.dataSource = self
        
        print("SpotDetail:",spotDetailDict)
        
        if spotDetailDict["event"] != nil{
            eventListArray = ((spotDetailDict.value(forKey: "event") as! NSArray) as! [Any])
        }
        if spotDetailDict["promotion"] != nil{
            promoListArray = ((spotDetailDict.value(forKey: "promotion") as! NSArray) as! [Any])
        }
        if spotDetailDict["competition"] != nil{
            compoListArray = ((spotDetailDict.value(forKey: "competition") as! NSArray) as! [Any])
        }
        
        tbl_spot_details.reloadData()
     
        if (UserDefaults.standard.value(forKey: "id")) != nil
        {
            if UserDefaults.standard.value(forKey: "user_type") as! String == "1"
            {
                if spotDetailDict["spot_creator"] != nil {
                    let localDict = (spotDetailDict.value(forKey: "spot_creator") as! NSDictionary)
                    let user_id = UserDefaults.standard.value(forKey: "id") as! NSInteger
                    if user_id == (localDict.value(forKey: "user_id") as! NSInteger)
                    {
                        self.callThisForValidation()
                        
                    }
                    else
                    {
                        button.isHidden = true
                    }
                }
                else{
                    button.isHidden = true
                }
            
            }
            else
            {
                button.isHidden = true

            }
        }
        else
        {
            button.isHidden = true

        }
        
        
        if let ttt = (spotDetailDict.value(forKey: "image_url") as? String)
        {
              bannerImg.sd_setImage(with: URL(string: spotDetailDict.value(forKey: "image_url") as! String), placeholderImage: UIImage(named:"bar.jpeg"), options: [], completed: nil)
        }
        
        if ((spotDetailDict.value(forKey: "name") as? String) != nil) {
            self.nameLbl.text! = (spotDetailDict.value(forKey: "name") as? String)!
        }
        if ((spotDetailDict.value(forKey: "spot_name") as? String) != nil) {
            self.nameLbl.text! = (spotDetailDict.value(forKey: "spot_name") as? String)!
        }
        
        if ((spotDetailDict.value(forKey: "spot_phone") as? String) != nil) {
            self.mobileNo_Label.text! = (spotDetailDict.value(forKey: "spot_phone") as? String)!
        }else{
            self.mobileNo_Label.text! = "unknown"
        }
        
        if ((spotDetailDict.value(forKey: "spot_website") as? String) != nil) {
             let text = (spotDetailDict.value(forKey: "spot_website") as? String)!
             self.link_Btn.setTitle(text, for:.normal)
        }
        else{
            self.link_Btn.setTitle("hoodable", for:.normal)
        }
        if ((spotDetailDict.value(forKey: "start_date") as? String) != nil) {
            self.date_Label.text! = (spotDetailDict.value(forKey: "start_date") as? String)!
        }
        if ((spotDetailDict.value(forKey: "spot_opening_time") as? String) != nil) {
            self.date_Label.text! = (spotDetailDict.value(forKey: "spot_opening_time") as? String)!
        }
        if ((spotDetailDict.value(forKey: "desc") as? String) != nil) {
            self.desc_Label.text! = (spotDetailDict.value(forKey: "desc") as? String)!
        }
        if ((spotDetailDict.value(forKey: "description") as? String) != nil) {
            self.desc_Label.text! = (spotDetailDict.value(forKey: "description") as? String)!
        }
        if ((spotDetailDict.value(forKey: "spot_description") as? String) != nil) {
            self.desc_Label.text! = (spotDetailDict.value(forKey: "spot_description") as? String)!
        }

        // Do any additional setup after loading the view.
    }
    
    //MARK: - UITableView Delegates & Datasource
    
    
    
    @IBAction func backAction (_ sender : Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func followAction (_ sender : Any)
    {
        if (UserDefaults.standard.value(forKey: "id")) != nil
        {
        }
        else
        {
            AppDelegate.instance().pushToLoginPage()

        }
    }
    
    @IBAction func linkAction (_ sender : Any)
    {
        
        if let url = URL(string: (spotDetailDict.value(forKey: "spot_website") as! String))
        {
        UIApplication.shared.open(url)
        }
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//MARK:-----TableView Methods------
extension SpotDetailViewController : UITableViewDataSource,UITableViewDelegate {
    
    //setting number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        if eventTypeString != "event" && eventTypeString != "promotion" && eventTypeString != "competition"
        {
            return self.section.count

        }
            return 0
    }
    
    //Setting headerView Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //Setting Header Customised View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //Declare cell
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! TableViewCell
        
        //Setting Header Components
        headerCell.titleLabel.text = self.section[section]
        headerCell.ButtonToShowHide.tag = section
        
        //Handling Button Title
        if self.collapaseHandlerArray.contains(self.section[section]){
            //if its opened
            headerCell.ButtonToShowHide.setTitle("Hide", for: .normal)
        }
        else{
            //if closed
            headerCell.ButtonToShowHide.setTitle("Show", for: .normal)
        }
        
        //Adding a target to button
        headerCell.ButtonToShowHide.addTarget(self, action: #selector(self.HandleheaderButton(sender:)), for: .touchUpInside)
        return headerCell.contentView
        
    }
    
    //Setting number of rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.collapaseHandlerArray.contains(self.section[section]){
            if section == 0
            {
                eventArray = eventListArray
                return eventListArray.count
            }
            if section == 1
            {
                eventArray = compoListArray
                return compoListArray.count
            }
            eventArray = promoListArray
            return promoListArray.count

        }
        else{
            return 0
        }
    }
    
    
    //Setting cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "DetailsTableViewCell"
        var cell: DetailsTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? DetailsTableViewCell
        
        if cell == nil {
            tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DetailsTableViewCell
        }
        
        self.localListArray = eventArray
        print("eventListArray",eventArray)
        if let ttt = ((self.localListArray[indexPath.row] as! NSDictionary)["image_url"] as? String)
        {
            cell.proImg.sd_setImage(with: URL(string: (self.localListArray[indexPath.row] as! NSDictionary)["image_url"] as! String), placeholderImage: UIImage(named:"bar.jpeg"), options: [], completed: nil)
        }
        
        cell.nameLbl.text = ((self.localListArray[indexPath.row] as! NSDictionary)["name"] as! String).capitalized
        cell.descLbl.text = ((self.localListArray[indexPath.row] as! NSDictionary)["description"] as! String)
        cell.openLbl.text = "Start Date- \(((self.localListArray[indexPath.row] as! NSDictionary)["start_date"] as! String))"
        
        return cell
        
    }
  
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 99
    }

    
    //Setting footer height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    //Header cell button Action
    @objc func HandleheaderButton(sender: UIButton){
        
        //check status of button
        if let buttonTitle = sender.title(for: .normal) {
            if buttonTitle == "Show"{
                //if yes
                self.collapaseHandlerArray.append(self.section[sender.tag])
                sender.setTitle("Hide", for: .normal)
            }
            else {
                //if no
                while self.collapaseHandlerArray.contains(self.section[sender.tag]){
                    if let itemToRemoveIndex = self.collapaseHandlerArray.index(of: self.section[sender.tag]) {
                        //remove title of header from array
                        self.collapaseHandlerArray.remove(at: itemToRemoveIndex)
                        sender.setTitle("Show", for: .normal)
                    }
                }
            }
        }
        //reload section
        tbl_spot_details.reloadSections(IndexSet(integer: sender.tag), with: .none)
    }
}


