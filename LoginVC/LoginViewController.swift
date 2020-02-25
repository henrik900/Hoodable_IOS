//
//  LoginViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 16/12/19.
//  Copyright © 2019 Rustam Atabaev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, WebServiceDelegate {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var mobTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginButton.layer.cornerRadius = 4

        loginView.layer.cornerRadius = 2
        loginView.layer.shadowColor = UIColor.black.cgColor
        loginView.layer.shadowOffset = CGSize(width: 0.5, height: 4.0) //Here your control your spread
        loginView.layer.shadowOpacity = 0.5
        loginView.layer.shadowRadius = 5.0
        
        // Do any additional setup after loading the view.
    }
    
    func nsStringIsValidEmail(_ checkString: String) -> Bool {
        let stricterFilter = true
        let stricterFilterString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let laxString = ".+@.+\\.[A-Za-z]{2}[A-Za-z]*"
        let emailRegex = stricterFilter ? stricterFilterString : laxString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: checkString)
    }
    
    @IBAction func loginAction (_ sender : Any)
    {
        var message = ""
        if self.mobTF.text!.count == 0 {
            message = "Please enter mob no."
        }
        else if nsStringIsValidEmail(self.mobTF.text!) == false {
            message = "Please enter valid email"
        }
        else if self.passwordTF.text!.count == 0 {
            message = "Please enter password."
        }
        if message != "" {
            AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: message)

        }
        else{
            
          
           AppDelegate.instance().addSpinLoaderView(show: true)
            
            let param = [
                "email" : "\(mobTF.text!)",
                 "password" : "\(passwordTF.text!)"
                ] as Dictionary <String, String>
            
         //   let param = "phone=\(mobTF.text!)&password=\(passwordTF.text!)"
            let serviceClass = WebServiceClass()
           
            serviceClass.delegate = self
            
            serviceClass.callwebServicewithDict(urlString: API_Methods.method_login, parameters:param, methodType: API_Methods.methodTypePost)
 
        }
    }
    
    @IBAction func registerAction (_ sender : Any)
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let  registerStartViewController = storyboard.instantiateViewController(withIdentifier: "RegisterStartViewController") as! RegisterStartViewController
        registerStartViewController.userTypeString = "0"
        navigationController?.pushViewController(registerStartViewController, animated: true)
    }
    
    @IBAction func backAction (_ sender : Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Web Service Delegates
    func getServiceResponse(responseData: AnyObject,  methodeString : String) {
        let responseValue:NSDictionary = responseData as! NSDictionary
        //print(responseValue)
        AppDelegate.instance().addSpinLoaderView(show: false)
 
        if responseValue["success"] as! NSInteger == 1
            {
               
                let localDict = responseValue["user"] as! NSDictionary
                
                print("SignIn trying() localDict",localDict);
                print("SignIn trying() responseValue",responseValue);
                
                UserDefaults.standard.set(localDict["id"], forKey: "id")
                UserDefaults.standard.set(localDict["name"], forKey: "name")
                UserDefaults.standard.set(localDict["phone"], forKey: "phone")
                UserDefaults.standard.set(localDict["family_name"], forKey: "family")
                UserDefaults.standard.set(localDict["email"], forKey: "email")
                UserDefaults.standard.set(responseValue["access_token"], forKey: "token")
                UserDefaults.standard.set(localDict["profile_image"], forKey: "profile_image")

                // identity_imagea
                if "\(localDict["upgrade"]!)" == "1"
                {
                    UserDefaults.standard.set("1", forKey: "user_type")
                }
                else
                {
                    UserDefaults.standard.set("\(localDict["user_type"]!)", forKey: "user_type")

                }
                
                AppDelegate.instance().pushToHomePage()
 
            }
        else
        {
              AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: responseValue["message"] as! String)
        }
        

    }
    
    func getServiceError(errorDesc: String) {
        AppDelegate.instance().addSpinLoaderView(show: false)
        AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: errorDesc)
        
    }
   
}
