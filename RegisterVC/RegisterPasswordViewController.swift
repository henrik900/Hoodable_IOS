//
//  RegisterPasswordViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 16/12/19.
//  Copyright © 2019 Rustam Atabaev. All rights reserved.
//

import UIKit

class RegisterPasswordViewController: UIViewController {

   
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var circle1Img: UIImageView!
    @IBOutlet weak var circle2Img: UIImageView!
    @IBOutlet weak var circle3Img: UIImageView!
    @IBOutlet weak var circle4Img: UIImageView!
    @IBOutlet weak var circle5Img: UIImageView!
    @IBOutlet weak var circle6Img: UIImageView!

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordTF: UITextField!

    var givenNameString = String()
    var familyNameString = String()
    var mobNoString = String()
    var dobString = String()
    var pincodeString = String()
    var emailString = String()
    var paypalString = String()
var userTypeString = String()

    var boolValue = Bool()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boolValue = true
        
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
    @IBAction func registerAction (_ sender : Any)
    {
        var message = ""
        if self.passwordTF.text!.count == 0 {
            message = "Please enter password."
        }
        
        if message != "" {
            AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: message)
            
        }
        else{
            
            if userTypeString == "0"
            {
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let  registerConfirmViewController = storyboard.instantiateViewController(withIdentifier: "RegisterConfirmViewController") as! RegisterConfirmViewController
            
            registerConfirmViewController.givenNameString = givenNameString
            registerConfirmViewController.familyNameString = familyNameString
            registerConfirmViewController.mobNoString = mobNoString
            registerConfirmViewController.dobString = dobString
            registerConfirmViewController.pincodeString = pincodeString
            registerConfirmViewController.passwordString = passwordTF.text!
            registerConfirmViewController.emailString = emailString
            registerConfirmViewController.paypalString = paypalString
            registerConfirmViewController.userTypeString = userTypeString

            
            navigationController?.pushViewController(registerConfirmViewController, animated: true)
            }
            else
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let  agentAddressViewController = storyboard.instantiateViewController(withIdentifier: "AgentAddressViewController") as! AgentAddressViewController
                
              /*  agentAddressViewController.givenNameString = givenNameString
                agentAddressViewController.familyNameString = familyNameString
                agentAddressViewController.mobNoString = mobNoString
                agentAddressViewController.dobString = dobString
                agentAddressViewController.pincodeString = pincodeString
                agentAddressViewController.passwordString = passwordTF.text!
                agentAddressViewController.emailString = emailString
                agentAddressViewController.paypalString = paypalString
                agentAddressViewController.userTypeString = userTypeString
                 */
                navigationController?.pushViewController(agentAddressViewController, animated: true)
            }
        }
    }
    
    
    @IBAction func seePasswordAction (_ sender : Any)
    {
       if boolValue == true
       {
        passwordTF.isSecureTextEntry = true
        boolValue = false
        }
        else
       {
        boolValue = true

        passwordTF.isSecureTextEntry = false

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
