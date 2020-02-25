//
//  RegisterDOBViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 16/12/19.
//  Copyright © 2019 Rustam Atabaev. All rights reserved.
//

import UIKit

class RegisterDOBViewController: UIViewController {

   
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var circle1Img: UIImageView!
    @IBOutlet weak var circle2Img: UIImageView!
    @IBOutlet weak var circle3Img: UIImageView!
    @IBOutlet weak var circle4Img: UIImageView!
    @IBOutlet weak var circle5Img: UIImageView!
    @IBOutlet weak var circle6Img: UIImageView!

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var dobTF: UITextField!

    var givenNameString = String()
    var familyNameString = String()
    var mobNoString = String()
    var emailString = String()
var userTypeString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.cornerRadius = 4
        
        
        registerView.layer.cornerRadius = 2
        registerView.layer.shadowColor = UIColor.black.cgColor
        registerView.layer.shadowOffset = CGSize(width: 0.5, height: 4.0) //Here your control your spread
        registerView.layer.shadowOpacity = 0.5
        registerView.layer.shadowRadius = 5.0
        
        
        circle1Img.layer.cornerRadius = 14
        circle2Img.layer.cornerRadius = 14
        circle3Img.layer.cornerRadius = 14
        circle4Img.layer.cornerRadius = 14
        circle5Img.layer.cornerRadius = 14
        circle6Img.layer.cornerRadius = 14

       
        
             // TODO: Your implementation for date
           
 
        // Do any additional setup after loading the view.
    }

    
    @IBAction func datePickBtnAction(_ sender: Any) {
      /*  RPicker.selectDate(title: "Select Date", didSelectDate: { (selectedDate) in
            // TODO: Your implementation for date
            self.dobTF.text = selectedDate.dateString("dd/MM/YYYY")
 
        })*/
        let selectedDate = Date().dateByAddingYears(-12)
        let maxDate = Date().dateByAddingYears(-12)
        let minDate = Date().dateByAddingYears(-70)
        
        RPicker.selectDate(title: "Select Date", selectedDate: selectedDate, minDate: minDate, maxDate: maxDate) { [weak self] (selectedDate) in
            // TODO: Your implementation for date
            self?.dobTF.text = selectedDate.dateString("dd/MM/YYYY")
            
        }
        
    }
    
    @IBAction func backAction (_ sender : Any)
    {
        
        navigationController?.popViewController(animated: true)
    }
    @IBAction func registerAction (_ sender : Any)
    {
        
        var message = ""
        if self.dobTF.text!.count == 0 {
            message = "Please select DOB."
        }
        
        if message != "" {
            AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: message)
            
        }
        else{
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let  registerPostalViewController = storyboard.instantiateViewController(withIdentifier: "RegisterPostalViewController") as! RegisterPostalViewController
            
            registerPostalViewController.givenNameString = givenNameString
            registerPostalViewController.familyNameString = familyNameString
            registerPostalViewController.mobNoString = mobNoString
            registerPostalViewController.emailString = emailString

            registerPostalViewController.dobString = dobTF.text!
            registerPostalViewController.userTypeString  =  userTypeString

            
            navigationController?.pushViewController(registerPostalViewController, animated: true)
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


extension Date {
    
    func dateString(_ format: String = "MMM-dd-YYYY, hh:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func dateByAddingYears(_ dYears: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
}

