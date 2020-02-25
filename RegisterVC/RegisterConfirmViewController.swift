//
//  RegisterConfirmViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 16/12/19.
//  Copyright © 2019 Rustam Atabaev. All rights reserved.
//

import UIKit

class RegisterConfirmViewController: UIViewController, WebServiceDelegate {

    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var circle1Img: UIImageView!
    @IBOutlet weak var circle2Img: UIImageView!
    @IBOutlet weak var circle3Img: UIImageView!
    @IBOutlet weak var circle4Img: UIImageView!
    @IBOutlet weak var circle5Img: UIImageView!
    @IBOutlet weak var circle6Img: UIImageView!

    @IBOutlet weak var registerButton: UIButton!
    
    var givenNameString = String()
    var familyNameString = String()
    var mobNoString = String()
    var dobString = String()
    var pincodeString = String()
    var passwordString = String()
    var emailString = String()
    var paypalString = String()
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
    @IBAction func registerAction (_ sender : Any)
    {

         AppDelegate.instance().addSpinLoaderView(show: true)
        
        let param = [
            "name" : "\(givenNameString)",
            "email" : "\(emailString)",
            "family_name" : "\(familyNameString)",
            "date_of_birth" : "\(dobString)",
            "postal_code" : "\(pincodeString)",
            "phone" : "\(mobNoString)",
            "password" : "\(passwordString)",
            "paypal_id" : "\(paypalString)",
            "user_type" : "0"
            ] as Dictionary <String, String>
        
      
        let serviceClass = WebServiceClass()
        
        serviceClass.delegate = self
        
        serviceClass.callwebServicewithDict(urlString: API_Methods.method_signup, parameters:param, methodType: API_Methods.methodTypePost)
      
        
    }
    
    
    
    //MARK: Web Service Delegates
    func getServiceResponse(responseData: AnyObject,  methodeString : String) {
        let responseValue:NSDictionary = responseData as! NSDictionary
        print(responseValue)
        AppDelegate.instance().addSpinLoaderView(show: false)
       
         AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: responseValue["message"] as! String)
        
        if responseValue["success"] as! NSInteger == 1
         {
            
            let localDict = responseValue["user"] as! NSDictionary
            
            UserDefaults.standard.set(localDict["id"], forKey: "id")
            UserDefaults.standard.set(localDict["name"], forKey: "name")
            UserDefaults.standard.set(localDict["phone"], forKey: "phone")
            UserDefaults.standard.set(localDict["family_name"], forKey: "family")
            UserDefaults.standard.set(localDict["email"], forKey: "email")
            UserDefaults.standard.set(responseValue["access_token"], forKey: "token")
            UserDefaults.standard.set("\(localDict["user_type"]!)", forKey: "user_type")
            UserDefaults.standard.set("testinguser", forKey: "profile_image")

            AppDelegate.instance().pushToHomePage()
            
       
 
         
         }
   
    }
    
    func getServiceError(errorDesc: String) {
        AppDelegate.instance().addSpinLoaderView(show: false)
        AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: errorDesc)
        
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
