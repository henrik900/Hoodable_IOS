//
//  AddSpotViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 28/01/20.
//  Copyright © 2020 Rustam Atabaev. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class AddSpotViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,WebServiceDelegate
 {
    var artworks: [Artwork] = []
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    
    var spotListArray = Array<Any>()
    var localSpotListArray = Array<Any>()

 
    @IBOutlet weak var cafename: UILabel!
 
    @IBOutlet weak var DoneBtn: UIButton!

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
    @IBOutlet weak var selectbusinesbtn: UIButton!

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
    @IBOutlet weak var nextbtn8: UIButton!
    @IBOutlet weak var previousbtn8: UIButton!

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var websiteTF: UITextField!
    @IBOutlet weak var endTF: UITextField!
    @IBOutlet weak var openTF: UITextField!
    @IBOutlet weak var descTF: UITextField!

    @IBOutlet weak var optionalBtn: UIButton!
    @IBOutlet weak var uploadPhotoBtn: UIButton!

   // @IBOutlet weak var btn5: UIButton!

    @IBOutlet weak var addSpotView: UIView!
    @IBOutlet weak var addNameView: UIView!
    @IBOutlet weak var optionalView: UIView!
    @IBOutlet weak var businessView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var openView: UIView!
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var websiteView: UIView!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var thanksView: UIView!
    @IBOutlet weak var descView: UIView!

    

    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    var businessidstr : String!
    var photoString = "0"

    var businessListArray = Array<Any>()

    
    var imagePicker = UIImagePickerController()
    var imageData = UIImage()
    var imgNameString = String()
    
 
      //MARK:-- Start Here
    override func viewDidLoad()
    {
        super.viewDidLoad()
        imgNameString = "0"
        businessidstr = "0"
        self.callSpotListAction()
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handletap(_:)))
        self.endTF.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handletap1(_:)))
        self.openTF.addGestureRecognizer(tap2)
        
         addNameView.isHidden = true
        optionalView.isHidden = true
        businessView.isHidden = true
        phoneView.isHidden = true
        websiteView.isHidden = true
        openView.isHidden =  true
        endView.isHidden =  true
        photoView.isHidden = true
        thanksView.isHidden = true
        descView.isHidden = true
        nextbtn.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn1.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn1.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn2.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn2.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn3.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn3.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn4.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn4.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn5.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn5.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn6.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn6.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn7.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn7.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        nextbtn8.setFAIcon(icon: .FAArrowCircleRight, iconSize: 30, forState: .normal)
        previousbtn8.setFAIcon(icon: .FAArrowCircleLeft, iconSize: 30, forState: .normal)
        
        
        addSpotBtn.layer.cornerRadius = 6
        addSpotBtn.layer.borderWidth = 1.0
        addSpotBtn.layer.borderColor = UIColor.white.cgColor
        
        selectbusinesbtn.layer.cornerRadius = 4
        selectbusinesbtn.layer.borderWidth = 1.0
        selectbusinesbtn.layer.borderColor = UIColor.white.cgColor
        
        uploadPhotoBtn.layer.cornerRadius = 6
        uploadPhotoBtn.layer.borderWidth = 1.0
        uploadPhotoBtn.layer.borderColor = UIColor.white.cgColor
        
        optionalBtn.layer.cornerRadius = 6
        optionalBtn.layer.borderWidth = 1.0
        optionalBtn.layer.borderColor = UIColor.white.cgColor
        
        self.callBusinessListAction()
        
        if let ttt =  AppDelegate.instance().locationManager.location
        {
            centerMapOnLocation(location: AppDelegate.instance().locationManager.location!)
            
        }
        mapView.delegate = self
        mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(DashBoardViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        // Do any additional setup after loading the view.
    }
  
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        
        if let dict = notification.userInfo as NSDictionary? {
            if let str_controler_name = dict["controlleraName"] as? String{
                if str_controler_name == "DashBoardVC" {
                    
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let  resetViewController = storyboard.instantiateViewController(withIdentifier: "AddSpotViewController") as! AddSpotViewController
                    navigationController?.pushViewController(resetViewController, animated: false)
                    
                    
                }
                else if str_controler_name == "HomeVC" {
                    
                    if  nil == (UserDefaults.standard.value(forKey: "id") as? NSInteger)
                    {
                        AppDelegate.instance().pushToLoginPage()
                        
                    }
                    else
                    {
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let  homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                      //  homeViewController.spotListArray = spotListArray
                        navigationController?.pushViewController(homeViewController, animated: false)
                    }
                    
                }
                if str_controler_name == "SideMenuVC" {
                    
                    
                    AppDelegate.instance().showSideMenu(value: true)
                    
                }
                else if str_controler_name == "SearchVC" {
                    
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let  searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
                     searchViewController.spotListArray = spotListArray

                    navigationController?.pushViewController(searchViewController, animated: false)
                    
                }
                else if str_controler_name == "NotificationVC" {
                    
                    if  nil == (UserDefaults.standard.value(forKey: "id") as? NSInteger)
                    {
                        AppDelegate.instance().pushToLoginPage()
                        
                    }
                    else
                    {
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let  resetViewController = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
                        navigationController?.pushViewController(resetViewController, animated: false)
                    }
                    
                }
            }
        }
    }
    
    
    
    
    @objc func handletap1(_ sender:UITapGestureRecognizer)
    {
        nameTF.resignFirstResponder()
        openTF.resignFirstResponder()
        endTF.resignFirstResponder()
        websiteTF.resignFirstResponder()
        phoneTF.resignFirstResponder()
        
        
        let selectedDate = Date().dateByAddingYears(0)
        let maxDate = Date().dateByAddingYears(75)
        let minDate = Date().dateByAddingYears(0)
        
        RPicker.selectDate(title: "Select Date", selectedDate: selectedDate, minDate: minDate, maxDate: maxDate) { [weak self] (selectedDate) in
            // TODO: Your implementation for date
            self?.openTF.text = selectedDate.dateString("YYYY-MM-dd HH:mm:ss")
        }
    }
    

    @objc func handletap(_ sender:UITapGestureRecognizer)
    {
         nameTF.resignFirstResponder()
        endTF.resignFirstResponder()
        websiteTF.resignFirstResponder()
        phoneTF.resignFirstResponder()
        
        
        let selectedDate = Date().dateByAddingYears(0)
        let maxDate = Date().dateByAddingYears(75)
        let minDate = Date().dateByAddingYears(0)
        
        RPicker.selectDate(title: "Select Date", selectedDate: selectedDate, minDate: minDate, maxDate: maxDate) { [weak self] (selectedDate) in
            // TODO: Your implementation for date
            
            self?.endTF.text = selectedDate.dateString("YYYY-MM-dd HH:mm:ss")
            
        }
    }
    
    
    @IBAction func spotDoneAction(_ sender: Any) {

        addNameView.isHidden = false
        optionalView.isHidden = true
        AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "This spot is already registered.")
    }
    
    @IBAction func datePickBtnAction(_ sender: Any) {
        
        
        let selectedDate = Date().dateByAddingYears(0)
        let maxDate = Date().dateByAddingYears(75)
        let minDate = Date().dateByAddingYears(0)
        
        RPicker.selectDate(title: "Select Date", selectedDate: selectedDate, minDate: minDate, maxDate: maxDate) { [weak self] (selectedDate) in
            // TODO: Your implementation for date
            
            self?.endTF.text = selectedDate.dateString("YYYY-MM-dd HH:mm:ss")

 
        }
      
        
    }
    
    @IBAction func selectbusinessAction (_ sender : UIButton)
    {

        var dummyList = Array<String>()
        
        for xx in self.businessListArray
        {
            dummyList.append( (xx as! NSDictionary).value(forKey: "name") as! String)
        }
        
        RPicker.selectOption(title: "Please Select", hideCancel: true, dataArray: dummyList, selectedIndex: 2) {[weak self] (selctedText, atIndex) in
            // TODO: Your implementation for selection
            self!.selectbusinesbtn.setTitle((self!.businessListArray[atIndex] as AnyObject).value(forKey: "name") as? String, for: .normal)
            let id = (self!.businessListArray[atIndex] as AnyObject).value(forKey: "id") as! Int
            self!.businessidstr = String(id)
            
            self?.endTF.text = ""
            self?.openTF.text = ""
        }
    }
    @IBAction func optionalAction (_ sender : UIButton)
    {
        
    }
   
    @IBAction func nextAction (_ sender : UIButton)
    {
        nameTF.resignFirstResponder()
        endTF.resignFirstResponder()
        websiteTF.resignFirstResponder()
        phoneTF.resignFirstResponder()
 
        if sender.tag == 102 {
            if nameTF.text?.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Enter Spot Name")
            }
            else
            {
           
               
                var check = 0
 
                for item in localSpotListArray
                {
                   if ((item as! NSDictionary).value(forKey: "spot_name")as! String) == nameTF.text
                   {
                        check = 1
                        break
                    }
                }
                
                if check == 1
                {
                     self.cafename.text = "Do you means " + "'" + "\(nameTF.text!)" + "'" + " ?"
                    addNameView.isHidden = true
                    optionalView.isHidden = false
                }
                else
                {
                    addNameView.isHidden = true
                    businessView.isHidden = false
                }
                
                
           
            }
        }
        else if sender.tag == 202 {
           
            businessView.isHidden = false
            optionalView.isHidden = true
         
        }
        else if sender.tag == 302 {
            
            if businessidstr == "0"
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Select Business Type")
            }
            else
            {
                if selectbusinesbtn.titleLabel?.text == "Events"
                {
                    businessView.isHidden = true
                    openView.isHidden = false
                }
                else
                {
                    businessView.isHidden = true
                    descView.isHidden = false
                }
         
            }
        }
        else if sender.tag == 802 {
            if openTF.text?.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Select Start Data")
            }
            else
            {
                endView.isHidden = false
                openView.isHidden = true
            }
        }
        else if sender.tag == 902 {
            if endTF.text?.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Select  End Date")
            }
            else
            {
                descView.isHidden = false
                endView.isHidden = true
            }
        }
        else if sender.tag == 402 {
            if phoneTF.text?.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Enter Phone No")
            }
            else
            {
            websiteView.isHidden = false
            phoneView.isHidden = true
            }
        }
        else if sender.tag == 602 {
            if websiteTF.text?.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Enter Website Name")
            }
            else
            {
            photoView.isHidden = false
            websiteView.isHidden = true
            }
        }
        else if sender.tag == 702 {
          if photoString == "0"
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Select Spot Picture")
            }
            else
            {
                self.callAddImageAction()
            }
        }
        else if sender.tag == 1002 {
            
            if descTF.text?.count == 0
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please Enter Description")
            }
            else
            {
                phoneView.isHidden = false
                descView.isHidden = true
            }
        }
    }
   
    
    @IBAction func previousAction (_ sender : UIButton)
    {
        if sender.tag == 101 {
           addNameView.isHidden = true
            addSpotView.isHidden = false
        }
        if sender.tag == 201 {
            addNameView.isHidden = false
            optionalView.isHidden = true
        }
        else if sender.tag == 301 {
            
            
            var check = 0
            
            for item in localSpotListArray
            {
                if ((item as! NSDictionary).value(forKey: "spot_name")as! String) == nameTF.text
                {
                    check = 1
                    break
                }
            }
            if check == 1
            {
                businessView.isHidden = true
                optionalView.isHidden = false
            }
            else
            {
                businessView.isHidden = true
                addNameView.isHidden = false
            }
        }
        else if sender.tag == 401 {
            
            descView.isHidden = false
            phoneView.isHidden = true
            
        }
        else if sender.tag == 801 {
            openView.isHidden = true
            businessView.isHidden = false
        }
        else if sender.tag == 901 {
            openView.isHidden = false
            endView.isHidden = true
        }
        else if sender.tag == 601 {
            phoneView.isHidden = false
            websiteView.isHidden = true
        }
        else if sender.tag == 701 {
            photoView.isHidden = true
            websiteView.isHidden = false
        }
        else if sender.tag == 1001 {
            if selectbusinesbtn.titleLabel?.text == "Events"
            {
                endView.isHidden = false
                descView.isHidden = true
            }
            else
            {
                businessView.isHidden = false
                descView.isHidden = true
            }
        }
    }
  
    
    @IBAction func addSpotAction (_ sender : Any)
    {
        addSpotView.isHidden = true
        addNameView.isHidden = false
    }
    
    @IBAction func backAction (_ sender : Any)
    {
        navigationController?.popViewController(animated: true)
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
    
    @IBAction func buttonOnClick(_ sender: UIButton)
    {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        imagePicker.delegate = self
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
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
    
    

    
    
    //MARK: Web Service Delegates
    func getServiceResponse(responseData: AnyObject, methodeString: String) {
        let responseValue:NSDictionary = responseData as! NSDictionary
        print(responseValue)
        

        if methodeString == API_Methods.method_uploadmedia
        {
            if responseValue["success"] as! NSInteger == 1
            {
                imgNameString = (responseValue["path"] as! NSDictionary).value(forKey: "spot_image") as! String
                self.callAddSpotAction()
            }
            else
            {
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Try Again")
            }
            
        }
        else if methodeString == API_Methods.method_spotlistAll
        {
            if responseValue["success"] as! NSInteger == 1
            {
 
                localSpotListArray = (responseValue["data"] as! NSArray) as! [Any]
                spotListArray = localSpotListArray
                for item in localSpotListArray
                {
                    let  item1 = item as! NSDictionary
                    
                    if (item1["competition"] as? NSArray) != nil
                    {
                        for competition in (item1["competition"] as! NSArray)
                        {
                            spotListArray.append(competition)
                        }
                    }
                    if (item1["promotion"] as? NSArray) != nil
                    {
                        for promotion in (item1["promotion"] as! NSArray)
                        {
                            spotListArray.append(promotion)
                            
                        }
                    }
                    if (item1["event"] as? NSArray) != nil
                    {
                        for event in (item1["event"] as! NSArray)
                        {
                            spotListArray.append(event)
                            
                        }
                    }
                }

            loadInitialData()
            mapView.addAnnotations(artworks)
            }
        }
        else if methodeString == API_Methods.method_categorylist
        {
            businessListArray = (responseValue["data"] as! NSArray) as! [Any]
        }
        else if methodeString == API_Methods.method_addspot
        {
            
            if responseValue["success"] as! NSInteger == 1
            {
                thanksView.isHidden = false
                photoView.isHidden = true
                AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: responseValue["message"] as! String)
            }
            AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: responseValue["message"] as! String)
        }
        AppDelegate.instance().addSpinLoaderView(show: false)
    }
    
    func getServiceError(errorDesc: String) {
        AppDelegate.instance().addSpinLoaderView(show: false)
        AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: errorDesc)
        
    }

    
    func callAddSpotAction()
    {

        let trimmedString = websiteTF.text!.trimmingCharacters(in: .whitespaces)

        let param = [
            "business_type_id" : businessidstr!,
            "category_id" : businessidstr!,
            "spot_name" : "\(nameTF.text!)",
            "spot_phone" : "\(phoneTF.text!)",
            "spot_website" : "\(websiteTF.text!)",
            "spot_description": "\(descTF.text!)",
            "spot_ending_time": "\(endTF.text!)",
            "spot_opening_time": "\(openTF.text!)",
            "image_url": imgNameString,
            
            "location" : "\(AppDelegate.instance().self.pickUpAddressString)",
            "latitude" : "\(AppDelegate.instance().pickUpLatitudeVal)",
            "longitude" : "\(AppDelegate.instance().pickUpLongitudeVal)"
            ] as Dictionary <String, String>
        
        let serviceClass = WebServiceClass()
        
        serviceClass.delegate = self
        
        serviceClass.callwebServicewithDict(urlString: API_Methods.method_addspot, parameters:param, methodType: API_Methods.methodTypePost)
    }
    
    
    func callSpotListAction()
    {

        let param = [
            "business_type_id" : "1"
            ] as Dictionary <String, String>
        
        let serviceClass = WebServiceClass()
        serviceClass.delegate = self
        serviceClass.callwebServicewithDict(urlString: API_Methods.method_spotlistAll, parameters:param, methodType: API_Methods.methodTypeGet)
    }

    func callBusinessListAction()
    {
        AppDelegate.instance().addSpinLoaderView(show: true)
        
        let param = [
            "business_type_id" : "1"
            ] as Dictionary <String, String>
        
        let serviceClass = WebServiceClass()
        serviceClass.delegate = self
        serviceClass.callwebServicewithDict(urlString: API_Methods.method_categorylist, parameters:param, methodType: API_Methods.methodTypeGet)
    }
   
    func callAddImageAction()
    {
        
        AppDelegate.instance().addSpinLoaderView(show: true)
        let serviceClass = WebServiceClass()
        serviceClass.delegate = self
        
        let parameters = [
            "": ""
        ]

        
        let imageData1 = imageData.jpegData(compressionQuality: 0.9)
        
        serviceClass.upload(params: parameters, imageData: imageData1!, urlString: API_Methods.method_uploadmedia , imagenameParamter: "spot_image")
        
    }
    
    
    
    // MARK: - CLLocationManager
    
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestAlwaysAuthorization()
        }
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // MARK: - Helper methods
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadInitialData() {
        
        let validWorks = spotListArray.flatMap { Artwork(json: [$0]) }
        artworks.append(contentsOf: validWorks)
    }
}


// MARK: - MKMapViewDelegate

extension AddSpotViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Artwork else { return nil }

        // 2
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView { // 3
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 4
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if annotation.discipline == "1"
        {
            view.markerTintColor = .green
            
        }
        else  if annotation.discipline == "2"
        {
            view.markerTintColor = .blue
            
        }
        else  if annotation.discipline == "3"
        {
            view.markerTintColor = .red
            
        }
        else  if annotation.discipline == "competition"
        {
            view.markerTintColor = .gray
        }
        else  if annotation.discipline == "promotion"
        {
            view.markerTintColor = .yellow
        }
        else  if annotation.discipline == "event"
        {
            view.markerTintColor = .red
        }
        
        return view
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        let location = view.annotation as! Artwork
        var spotid = location.idString
        var indd = NSDictionary()
        for item in spotListArray {
            
            if "\((item as! NSDictionary).value(forKey: "id") as! NSInteger)" == spotid
            {
                indd = (item as! NSDictionary)
                break
            }
        }

        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let  spotDetailViewController = storyboard.instantiateViewController(withIdentifier: "SpotDetailViewController") as! SpotDetailViewController
        spotDetailViewController.spotDetailDict = indd
        spotDetailViewController.eventTypeString = location.discipline as NSString
        navigationController?.pushViewController(spotDetailViewController, animated: true)
        
        
        
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

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        
      /*  var originalString = "test/test=42"
        var customAllowedSet =  NSCharacterSet(charactersInString:"=\"#%/<>?@\\^`{|}").invertedSet
        var escapedString = originalString.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        println("escapedString: \(escapedString)")
        */
        
        return self.replace(string: " ", replacement: "")
    }
}
