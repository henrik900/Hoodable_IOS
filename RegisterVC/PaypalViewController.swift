//
//  PaypalViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 05/02/20.
//  Copyright © 2020 Rustam Atabaev. All rights reserved.
//

import UIKit

class PaypalViewController: UIViewController {
    
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var circle1Img: UIImageView!
    @IBOutlet weak var circle2Img: UIImageView!
    @IBOutlet weak var circle3Img: UIImageView!
    @IBOutlet weak var circle4Img: UIImageView!
    @IBOutlet weak var circle5Img: UIImageView!
    @IBOutlet weak var circle6Img: UIImageView!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var paypalTF: UITextField!
    
    var givenNameString = String()
    var familyNameString = String()
    var mobNoString = String()
    var dobString = String()
    var emailString = String()
    var pincodeString = String()
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
        
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction (_ sender : Any)
    {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func nsStringIsValidEmail(_ checkString: String) -> Bool {
        let stricterFilter = true
        let stricterFilterString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let laxString = ".+@.+\\.[A-Za-z]{2}[A-Za-z]*"
        let emailRegex = stricterFilter ? stricterFilterString : laxString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: checkString)
    }
    
    @IBAction func registerAction (_ sender : Any)
    {
        var message = ""
        if self.paypalTF.text!.count == 0 {
            message = "Please enter paypal id."
        }
        else if nsStringIsValidEmail(self.paypalTF.text!) == false
        {
            message = "Please enter valid paypal id."
            
        }
        
        if message != "" {
            AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: message)
            
        }
        else{
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let  registerPasswordViewController = storyboard.instantiateViewController(withIdentifier: "RegisterPasswordViewController") as! RegisterPasswordViewController
            
            registerPasswordViewController.givenNameString = givenNameString
            registerPasswordViewController.familyNameString = familyNameString
            registerPasswordViewController.mobNoString = mobNoString
            registerPasswordViewController.dobString = dobString
            registerPasswordViewController.emailString = emailString
            registerPasswordViewController.pincodeString = pincodeString
            registerPasswordViewController.paypalString = paypalTF.text!
            registerPasswordViewController.userTypeString  =  userTypeString

            navigationController?.pushViewController(registerPasswordViewController, animated: true)
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
