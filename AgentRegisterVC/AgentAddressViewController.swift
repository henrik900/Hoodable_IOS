//
//  AgentAddressViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 06/02/20.
//  Copyright © 2020 Rustam Atabaev. All rights reserved.
//

import UIKit

class AgentAddressViewController: UIViewController {
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var circle1Img: UIImageView!
    @IBOutlet weak var circle2Img: UIImageView!
    @IBOutlet weak var circle3Img: UIImageView!
    @IBOutlet weak var circle4Img: UIImageView!
    @IBOutlet weak var circle5Img: UIImageView!
 
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!

    
    var givenNameString = String()
    var familyNameString = String()
    var emailString = String()
    var paypalString = String()
 
    
    
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
        var message = ""
        if self.streetTF.text!.count == 0 {
            message = "Please enter street address."
        }
        else if self.countryTF.text!.count == 0 {
            message = "Please enter country name"
        }
        else if self.cityTF.text!.count == 0 {
            message = "Please enter city name"
        }
        if message != "" {
            AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: message)
            
        }
        else{
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let  agentPhotoViewController = storyboard.instantiateViewController(withIdentifier: "AgentPasswordViewController") as! AgentPasswordViewController
            
            agentPhotoViewController.givenNameString = givenNameString
            agentPhotoViewController.familyNameString = familyNameString
            agentPhotoViewController.emailString = emailString
            agentPhotoViewController.paypalString = paypalString
            agentPhotoViewController.streetString = streetTF.text!
            agentPhotoViewController.stateString = cityTF.text!
            agentPhotoViewController.countryString = countryTF.text!

            navigationController?.pushViewController(agentPhotoViewController, animated: true)
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
