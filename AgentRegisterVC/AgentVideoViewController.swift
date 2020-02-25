//
//  AgentVideoViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 06/02/20.
//  Copyright © 2020 Rustam Atabaev. All rights reserved.
//


import UIKit

class AgentVideoViewController: UIViewController, WebServiceDelegate {

    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var circle1Img: UIImageView!
    @IBOutlet weak var circle2Img: UIImageView!
    @IBOutlet weak var circle3Img: UIImageView!
    @IBOutlet weak var circle4Img: UIImageView!
    @IBOutlet weak var circle5Img: UIImageView!
 
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    
    var givenNameString = String()
    var familyNameString = String()
    var mobNoString = String()
    var dobString = String()
    var pincodeString = String()
    var passwordString = String()
    var emailString = String()
    var paypalString = String()
    var userTypeString = String()
    var photoString = String()
    var videoString = String()
    var stateString = String()
    var countryString = String()
    var streetString = String()

    
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
            "email" : "\(emailString)",
            "state_id" : "1",
            "address" : "\(streetString)",
            "country_id" : "1",
            "name" : "\(givenNameString)",
            "family_name" : "\(familyNameString)",
            "date_of_birth" : "",
             "identity_image" : "\(photoString)",
            "video_clip" : "",
            "password" : "\(passwordString)",
            "paypal_id" : "\(paypalString)",
            "postal_code" : "",
            "phone" : "",
            "user_type" : "1"
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
                
            
            
            
 
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let  registerDOBViewController = storyboard.instantiateViewController(withIdentifier: "AgentConfirmViewController") as! AgentConfirmViewController
            navigationController?.pushViewController(registerDOBViewController, animated: true)
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

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
