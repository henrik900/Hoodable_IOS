//
//  RegisterStartViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 17/12/19.
//  Copyright © 2019 Rustam Atabaev. All rights reserved.
//

import UIKit

class RegisterStartViewController: UIViewController {

    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var circle1Img: UIImageView!
    @IBOutlet weak var circle2Img: UIImageView!
    @IBOutlet weak var circle3Img: UIImageView!
    @IBOutlet weak var circle4Img: UIImageView!
    @IBOutlet weak var circle5Img: UIImageView!
    @IBOutlet weak var circle6Img: UIImageView!

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var msgTV: UITextView!
    var userTypeString = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.cornerRadius = 4
 
      //  msgTV.layer.borderColor = UIColor.darkGray as! CGColor
        msgTV.layer.borderWidth = 0.5
        
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
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let  resetViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        resetViewController.userTypeString = userTypeString
        navigationController?.pushViewController(resetViewController, animated: true)
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
