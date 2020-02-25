//
//  AgentRegisterViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 06/02/20.
//  Copyright © 2020 Rustam Atabaev. All rights reserved.
//

import UIKit

class AgentRegisterViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var msgTV: UITextView!
    @IBOutlet weak var registerView: UIView!

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

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backAction (_ sender : Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerAction (_ sender : Any)
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let  registerViewController = storyboard.instantiateViewController(withIdentifier: "AgentNameViewController") as! AgentNameViewController
      //  registerViewController.userTypeString = "1"
        navigationController?.pushViewController(registerViewController, animated: true)
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
