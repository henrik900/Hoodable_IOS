//
//  AddEventViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 04/02/20.
//  Copyright © 2020 Rustam Atabaev. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, WebServiceDelegate
{
    
    @IBOutlet weak var addSpotBtn: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var nextbtn: UIButton!
    @IBOutlet weak var previousbtn: UIButton!
    @IBOutlet weak var nextbtn1: UIButton!
    @IBOutlet weak var previousbtn1: UIButton!
    @IBOutlet weak var nextbtn2: UIButton!
    @IBOutlet weak var previousbtn2: UIButton!
    @IBOutlet weak var nextbtn3: UIButton!
    @IBOutlet weak var previousbtn3: UIButton!
    @IBOutlet weak var nextbtn4: UIButton!
    @IBOutlet weak var previousbtn4: UIButton!
    @IBOutlet weak var nextbtn5: UIButton!
    @IBOutlet weak var previousbtn5: UIButton!
    @IBOutlet weak var nextbtn6: UIButton!
    @IBOutlet weak var previousbtn6: UIButton!
    @IBOutlet weak var nextbtn7: UIButton!
    @IBOutlet weak var previousbtn7: UIButton!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descTF: UITextField!
    @IBOutlet weak var priceeTF: UITextField!
    @IBOutlet weak var endTF: UITextField!
    @IBOutlet weak var openTF: UITextField!
    @IBOutlet weak var crystalTF: UITextField!

    @IBOutlet weak var optionalBtn: UIButton!
    @IBOutlet weak var uploadPhotoBtn: UIButton!
    
    // @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var addEventView: UIView!
    @IBOutlet weak var addNameView: UIView!
    @IBOutlet weak var descView: UIView!
    @IBOutlet weak var openingView: UIView!
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var crystalView: UIView!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var thanksView: UIView!
    
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    
    var photoString = "0"
    var idString = NSInteger()

    var imagePicker = UIImagePickerController()
    var imageData = UIImage()
    var imgNameString = String()

    
    @objc func handletap1(_ sender:UITapGestureRecognizer)
    {

        let selectedDate = Date().dateByAddingYears(0)
        let maxDate = Date().dateByAddingYears(72)
        let minDate = Date().dateByAddingYears(0)
        
        RPicker.selectDate(title: "Select Date", selectedDate: selectedDate, minDate: minDate, maxDate: maxDate) { [weak self] (selectedDate) in
            // TODO: Your implementation for date
            
            self?.openTF.text = selectedDate.dateString("YYYY-MM-dd HH:mm:ss")
            
        }
    }

    
    @objc func handletap(_ sender:UITapGestureRecognizer)
    {
        
        var localArray = NSArray()
        localArray = self.openTF.text?.components(separatedBy: " ") as! NSArray
        localArray = (localArray[0] as! String).components(separatedBy: "-") as NSArray
        
        let selectedDate = Date().dateByAddingYears(0)
        let maxDate = Date().dateByAddingYears(72)
        let minDate = Date().dateByAddingYears(0)
        
        
        RPicker.selectDate(title: "Select Date", selectedDate: selectedDate, minDate: minDate, maxDate: maxDate) { [weak self] (selectedDate) in
            // TODO: Your implementation for date
            
           
            self?.endTF.text = selectedDate.dateString("YYYY-MM-dd HH:mm:ss")
            
        }
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgNameString = "0"
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handletap1(_:)))
        self.openTF.addGestureRecognizer(tap1)
        
        let tap12 = UITapGestureRecognizer(target: self, action: #selector(self.handletap(_:)))
        self.endTF.addGestureRecognizer(tap12)
        
        addNameView.isHidden = true
        descView.isHidden = true
        openingView.isHidden = true
        endView.isHidden = true
        priceView.isHidden = true
        crystalView.isHidden =  true
        photoView.isHidden = true
        thanksView.isHidden = true
        
       
        nextbtn.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn1.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn1.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
       nextbtn7.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
       previousbtn7.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn3.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn3.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn4.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn4.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn5.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn5.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn6.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn6.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        
        addSpotBtn.layer.cornerRadius = 6
        addSpotBtn.layer.borderWidth = 1.0
        addSpotBtn.layer.borderColor = UIColor.white.cgColor
        
        uploadPhotoBtn.layer.cornerRadius = 6
        uploadPhotoBtn.layer.borderWidth = 1.0
        uploadPhotoBtn.layer.borderColor = UIColor.white.cgColor
        
 
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func nextAction (_ sender : UIButton)
    {
        if sender.tag == 102 {
            if self.nameTF.text!.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Enter Event Name")
            }
            else
            {
            addNameView.isHidden = true
            descView.isHidden = false
            }
        }
        else if sender.tag == 202 {
            if self.descTF.text!.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Enter Spot Discription")
            }
            else
            {
            openingView.isHidden = false
            descView.isHidden = true
            }
        }
        else if sender.tag == 302 {
            if self.openTF.text!.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Select Event Starting Time")
            }
            else
            {
            openingView.isHidden = true
            endView.isHidden = false
            }
        }
        else if sender.tag == 402 {
           
            if self.openTF.text!.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Select Event End Time")
            }
            else
            {
            photoView.isHidden = false
            endView.isHidden = true
            }
          
        }
        else if sender.tag == 502 {
            
            
            if imgNameString == "0"
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Select Image")
            }
            else
            {
                photoView.isHidden = true
                priceView.isHidden = false
            }
       
        }
        else if sender.tag == 602 {
            if self.openTF.text!.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Enter Winning Price")
            }
            else
            {
            crystalView.isHidden = false
            priceView.isHidden = true
            }
        }
        else if sender.tag == 702 {
            if self.openTF.text!.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Enter Crystal Count")
            }
            else
            {
                self.callAddPromotionImageAction()
          
            }
        }
    }
    
    
    @IBAction func previousAction (_ sender : UIButton)
    {
        if sender.tag == 101 {
            addNameView.isHidden = true
            addEventView.isHidden = false
        }
        if sender.tag == 201 {
            addNameView.isHidden = false
            descView.isHidden = true
        }
        else if sender.tag == 301 {
            openingView.isHidden = true
            descView.isHidden = false
        }
        else if sender.tag == 401 {
            openingView.isHidden = false
            endView.isHidden = true
        }
        else if sender.tag == 501 {
            photoView.isHidden = true
            endView.isHidden = false
        }
        else if sender.tag == 601 {
            photoView.isHidden = false
            priceView.isHidden = true
        }
        else if sender.tag == 701 {
            crystalView.isHidden = true
            priceView.isHidden = false
        }
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
        
        serviceClass.upload(params: parameters, imageData: imageData1!, urlString: API_Methods.method_uploadmedia , imagenameParamter: "event_image")
        
    }
    
    func callAddEventAction()
    {
        crystalTF.resignFirstResponder()
        AppDelegate.instance().addSpinLoaderView(show: true)
         let param = [
            "event_type" : "event",
            "spot_id" : "\(idString)",
            "user_id" : "\(UserDefaults.standard.value(forKey: "id") as! NSInteger)",
            "name" : "\(nameTF.text!)",
            "description": descTF.text!,
            "start_date": openTF.text!,
            "end_date": endTF.text!,
            "image_url": imgNameString,
            "prizes": priceeTF.text!,
            "crystal": crystalTF.text!,
            "location" : "\(AppDelegate.instance().self.pickUpAddressString)",
            "latitude" : "\(AppDelegate.instance().pickUpLatitudeVal)",
            "longitude" : "\(AppDelegate.instance().pickUpLongitudeVal)"
            ] as Dictionary <String, String>
        
        let serviceClass = WebServiceClass()
        
        serviceClass.delegate = self
        
        serviceClass.callwebServicewithDict(urlString: API_Methods.method_addevent, parameters:param, methodType: API_Methods.methodTypePost)
    }
   
    
    
    //MARK: Web Service Delegates
    func getServiceResponse(responseData: AnyObject, methodeString: String) {
        let responseValue:NSDictionary = responseData as! NSDictionary
        print(responseValue)
        AppDelegate.instance().addSpinLoaderView(show: false)
        
        if methodeString == API_Methods.method_uploadmedia
        {
            if responseValue["success"] as! NSInteger == 1
            {
                imgNameString = (responseValue["path"] as! NSDictionary).value(forKey: "event_image") as! String
                self.callAddEventAction()
            }
            else
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Try Again")
            }
            
        }
        else  if methodeString == API_Methods.method_addevent
        {
            
            if responseValue["success"] as! NSInteger == 1
            {
                crystalView.isHidden = true
                thanksView.isHidden = false
                
            }
            AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: responseValue["message"] as! String)
            
        }
        
    }
    
    func getServiceError(errorDesc: String) {
        AppDelegate.instance().addSpinLoaderView(show: false)
        AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: errorDesc)
        
    }
    
    
    
    @IBAction func addSpotAction (_ sender : Any)
    {
        addEventView.isHidden = true
        addNameView.isHidden = false
    }
    
    @IBAction func buttonOnClick(_ sender: UIButton)
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
        
        
        imgNameString = "1"
        
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
    
    
    

    
    @IBAction func backAction (_ sender : Any)
    {
        navigationController?.popViewController(animated: true)
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
