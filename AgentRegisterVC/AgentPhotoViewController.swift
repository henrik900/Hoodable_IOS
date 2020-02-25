//
//  AgentPhotoViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 06/02/20.
//  Copyright © 2020 Rustam Atabaev. All rights reserved.
//

import UIKit

class AgentPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, WebServiceDelegate {

    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var circle1Img: UIImageView!
    @IBOutlet weak var circle2Img: UIImageView!
    @IBOutlet weak var circle3Img: UIImageView!
    @IBOutlet weak var circle4Img: UIImageView!
    @IBOutlet weak var circle5Img: UIImageView!
 
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    var imagePicker = UIImagePickerController()

    
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
    var stateString = String()
    var countryString = String()
    var streetString = String()
    var imageData = UIImage()

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        photoString = "0"
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
    
    
    
    func callAddPromotionImageAction()
    {
        
        AppDelegate.instance().addSpinLoaderView(show: true)
        let serviceClass = WebServiceClass()
        serviceClass.delegate = self
        
        let parameters = [
            "": ""
        ]

        let imageData1 = imageData.jpegData(compressionQuality: 0.9)
        
        serviceClass.upload(params: parameters, imageData: imageData1!, urlString: API_Methods.method_uploadmedia , imagenameParamter: "identity_image")
        
    }
    
     func callThisAgentSignupMethode()
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
        
        if methodeString == API_Methods.method_uploadmedia
        {
            if responseValue["success"] as! NSInteger == 1
            {
                photoString = (responseValue["path"] as! NSDictionary).value(forKey: "identity_image") as! String
                 /* let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                 let  agentVideoViewController = storyboard.instantiateViewController(withIdentifier: "AgentVideoViewController") as! AgentVideoViewController
                 
                 agentVideoViewController.givenNameString = givenNameString
                 agentVideoViewController.familyNameString = familyNameString
                 agentVideoViewController.passwordString = passwordString
                 agentVideoViewController.emailString = emailString
                 agentVideoViewController.paypalString = paypalString
                 agentVideoViewController.photoString = str
                 agentVideoViewController.stateString = stateString
                 agentVideoViewController.countryString = countryString
                 agentVideoViewController.streetString = streetString
                 
                 navigationController?.pushViewController(agentVideoViewController, animated: true)
                 */
                
                self.callThisAgentSignupMethode()
            }
            else
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Try Again")
            }
            
        }
        else if methodeString == API_Methods.method_signup
        {
            
            
            if responseValue["success"] as! NSInteger == 1
            {
                let localDict = responseValue["user"] as! NSDictionary
                
                print("SignUp() localDict:",localDict)
                print("SignUp() localDict:",responseValue)
                
                UserDefaults.standard.set(localDict["id"], forKey: "id")
                UserDefaults.standard.set(localDict["name"], forKey: "name")
                UserDefaults.standard.set(localDict["family_name"], forKey: "family")
                UserDefaults.standard.set(localDict["email"], forKey: "email")
                UserDefaults.standard.set(responseValue["access_token"], forKey: "token")
            
                UserDefaults.standard.set("\(localDict["user_type"]!)", forKey: "user_type")
                UserDefaults.standard.set("\(localDict["identity_image"]!)", forKey: "profile_image")

            
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let  registerDOBViewController = storyboard.instantiateViewController(withIdentifier: "AgentConfirmViewController") as! AgentConfirmViewController
                navigationController?.pushViewController(registerDOBViewController, animated: true)
            }
            else
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: responseValue["message"] as! String)
            }
        }
    }
    
    func getServiceError(errorDesc: String) {
        AppDelegate.instance().addSpinLoaderView(show: false)
        AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: errorDesc)
        
    }
    
    
    
   
    
   
    
    @IBAction func registerAction (_ sender : Any)
    {

        if photoString == "0"
        {
            AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please select profile picture")
        }
        else
        {
            self.callAddPromotionImageAction()

        }
        
    }
    
    
    @IBAction func photoOnClick(_ sender: UIButton)
    {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        imagePicker.delegate = self;

        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK:-- ImagePicker delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let numberOfImages: UInt32 = 10000
        let random = arc4random_uniform(numberOfImages)
        
        let path = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
        print("ImagePath",path)
        photoString = "1"
        
        imageData =  self.resizeImage(image: selectedImage)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func resizeImage(image: UIImage) -> UIImage {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 400.0
        let maxWidth: Float = 300.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        //50 percent compression
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        let imageData =  img?.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }
    
    
    
}
