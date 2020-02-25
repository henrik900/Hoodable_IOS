//
//  PromotionViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 05/02/20.
//  Copyright © 2020 Rustam Atabaev. All rights reserved.
//

import UIKit

class PromotionViewController: UIViewController, WebServiceDelegate
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
    
    var imagePicker = UIImagePickerController()
    var imageData = UIImage()
    var imgNameString = String()


    var idString = NSInteger()

    
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
        photoView.isHidden = true
        thanksView.isHidden = true
        
        
        nextbtn.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn1.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn1.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn3.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn3.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn4.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn4.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn5.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn5.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
       
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
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Enter Promotion Name")
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
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Enter Promotion Description")
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
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Select Promotion Starting Time")
            }
            else
            {
            openingView.isHidden = true
            endView.isHidden = false
            }
        }
        else if sender.tag == 402 {
            if self.endTF.text!.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Select End Time")
            }
            else
            {
            photoView.isHidden = false
            endView.isHidden = true
            }
        }
        else if sender.tag == 502 {
            
            if imgNameString  == "0"
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Select Image")
            }
            else
            {
                self.callAddPromotionImageAction()

            }
            
          
          
        }
    }
    
    
    func uploadImage(paramName: String, fileName: String, image: UIImage) {
        let url = URL(string: "http://amigradus.xyz/hoodable/ap1i/v1/upload/image")
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        let session = URLSession.shared
        
        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var data = Data()
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            }
        }).resume()
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

    
    func callAddPromotionAction()
    {
        AppDelegate.instance().addSpinLoaderView(show: true)
        let param = [
            "event_type" : "promotion",
            "spot_id" : "\(idString)",
            "user_id" : "\(UserDefaults.standard.value(forKey: "id") as! NSInteger)",
            "name" : "\(nameTF.text!)",
            "description": descTF.text!,
            "start_date": openTF.text!,
            "end_date": endTF.text!,
            "image_url": imgNameString,
            "prizes": "",
            "crystal": "",
            "location" : "\(AppDelegate.instance().self.pickUpAddressString)",
            "latitude" : "\(AppDelegate.instance().pickUpLatitudeVal)",
            "longitude" : "\(AppDelegate.instance().pickUpLongitudeVal)"
            ] as Dictionary <String, String>
        
        let serviceClass = WebServiceClass()

        serviceClass.delegate = self
        serviceClass.callwebServicewithDict(urlString: API_Methods.method_addpromotion, parameters:param, methodType: API_Methods.methodTypePost)
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
                self.callAddPromotionAction()
            }
            else
            {
                  AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Try Again")
            }

        }
        else if methodeString == API_Methods.method_addpromotion
        {
            if responseValue["success"] as! NSInteger == 1
            {
                photoView.isHidden = true
                thanksView.isHidden = false
            }
            AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: responseValue["message"] as! String)
            
        }
        
    }
    
    func getServiceError(errorDesc: String) {
        AppDelegate.instance().addSpinLoaderView(show: false)
        AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: errorDesc)
        
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

extension PromotionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

    
    

    
   
}
