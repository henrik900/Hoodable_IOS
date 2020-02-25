//
//  HomeViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 18/12/19.
//  Copyright © 2019 Rustam Atabaev. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage


class HomeViewController: UIViewController, WebServiceDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var otpView: UIView!
    var spotListArray = Array<Any>()

    @IBOutlet weak var homeCollectionView: UICollectionView!

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var upgradeBtn: UIButton!
    @IBOutlet weak var otpBtn: UIButton!

    @IBOutlet weak var otpTF: UITextField!
    var imagePicker = UIImagePickerController()
    var imageData = UIImage()
    var imgNameString = String()

    var param = Dictionary<String, Any>()
   
    func cttt()  {
        
    }
    
    func callSpotListAction()
    {
        AppDelegate.instance().addSpinLoaderView(show: true)

        let param = [
            "business_type_id" : "1"
            ] as Dictionary <String, String>
        
        let serviceClass = WebServiceClass()
        serviceClass.delegate = self
        serviceClass.callwebServicewithDict(urlString: API_Methods.method_spotlist, parameters:param, methodType: API_Methods.methodTypeGet)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           profileImg.sd_setImage(with: URL(string: (UserDefaults.standard.value(forKey: "profile_image") as! String)), placeholderImage: UIImage(named:"256-512.png"), options: [], completed: nil)
        
        self.callSpotListAction()
        
        if UserDefaults.standard.value(forKey: "user_type") as! String == "1"
        {
            upgradeBtn.setTitle("Pro User", for: .normal)
            otpBtn.isHidden = true
        }
        
        otpView.layer.borderColor = UIColor.lightGray.cgColor
        otpView.layer.borderWidth = 1
       /* otpView.layer.cornerRadius = 2
        otpView.layer.shadowColor = UIColor.black.cgColor
        otpView.layer.shadowOffset = CGSize(width: 0.5, height: 4.0) //Here your control your spread
        otpView.layer.shadowOpacity = 0.5
        otpView.layer.shadowRadius = 5.0
         */
        otpView.isHidden = true

        otpBtn.layer.cornerRadius = 4
        upgradeBtn.layer.cornerRadius = 4
 
        nameLbl.text  = "\(UserDefaults.standard.value(forKey: "name") as! String) \(UserDefaults.standard.value(forKey: "family") as! String)".capitalized
        profileImg.layer.cornerRadius = 50
        // Do any additional setup after loading the view.
    }

    
    @IBAction func cancelAction (_ sender : Any)
    {
        otpView.isHidden = true

    }
    
    
     func callThisForList()
    {
        otpView.isHidden = true
        
        if upgradeBtn.titleLabel?.text == "Upgrade" {
            AppDelegate.instance().addSpinLoaderView(show: true)
            
            let param = [ "id" : "1"
                ] as Dictionary <String, String>
            
            let serviceClass = WebServiceClass()
            
            serviceClass.delegate = self
            
            serviceClass.callwebServicewithDict(urlString: API_Methods.method_upgradeRequest, parameters:param, methodType: API_Methods.methodTypePost)
        }
        
    }

    
    @IBAction func upgradeAction (_ sender : Any)
    {
        otpView.isHidden = true
        
        if upgradeBtn.titleLabel?.text == "Upgrade" {
            AppDelegate.instance().addSpinLoaderView(show: true)
            
            let param = [ "id" : "1"
                ] as Dictionary <String, String>
            
            let serviceClass = WebServiceClass()
            
            serviceClass.delegate = self
            
            serviceClass.callwebServicewithDict(urlString: API_Methods.method_upgradeRequest, parameters:param, methodType: API_Methods.methodTypePost)
        }
        
    }
    
    func callProfileImageAction()
    {
        
        AppDelegate.instance().addSpinLoaderView(show: true)
        let serviceClass = WebServiceClass()
        serviceClass.delegate = self
        
        let parameters = [
            "": ""
        ]
        
        let imageData1 = imageData.jpegData(compressionQuality: 0.9)
        
        serviceClass.uploadProfile(params: parameters, imageData: imageData1!, urlString: API_Methods.method_uploadprofile , imagenameParamter: "profile_image")
        
    }

    
    
    //MARK: Web Service Delegates
     func getServiceResponse(responseData: AnyObject,  methodeString : String){
        let responseValue:NSDictionary = responseData as! NSDictionary
        print(responseValue)
        AppDelegate.instance().addSpinLoaderView(show: false)

        
        if methodeString == API_Methods.method_uploadprofile
        {
             AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: responseValue["message"] as! String)
        }
        else if methodeString == API_Methods.method_spotlist
        {
            if responseValue["success"] as! NSInteger == 1
            {
                spotListArray = (responseValue["data"] as! NSArray) as! [Any]
                homeCollectionView.reloadData()
            }
            
        }
        else if methodeString == API_Methods.method_userUpgrade
        {
            if responseValue["success"] as! NSInteger == 1
            {
                upgradeBtn.setTitle("Pro User", for: .normal)
                otpBtn.isHidden = true
                otpView.isHidden = true
                UserDefaults.standard.set("1", forKey: "user_type")
            }
            
        }
        else
        {
            if responseValue["success"] as! NSInteger == 1
            {
                
            }
              AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: responseValue["message"] as! String)
        }
       
        
       
    }

    
    func getServiceError(errorDesc: String) {
        AppDelegate.instance().addSpinLoaderView(show: false)
        AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: errorDesc)
        
    }
    
    
    
   
 
    
    @IBAction func openverifyAction(_ sender: Any) {
        
        otpView.isHidden = false
    }
    @IBAction func otpVerifyAction(_ sender: Any) {

        if otpTF.text?.count == 0 {
            
            AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: "Please enter your code")
        }
        else
        {
        
            otpTF.resignFirstResponder()
        AppDelegate.instance().addSpinLoaderView(show: true)
        
        let param = [ "otp" : otpTF.text!
            ] as Dictionary <String, String>
        
        let serviceClass = WebServiceClass()
        
        serviceClass.delegate = self
        
        serviceClass.callwebServicewithDict(urlString: API_Methods.method_userUpgrade, parameters:param, methodType: API_Methods.methodTypePost)
        }
    }
    @IBAction func sideMenuAction(_ sender: Any) {
        AppDelegate.instance().showSideMenu(value: true)
    }
    
    
    // MARK: CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spotListArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let identifier = "HomeCollectionViewCell"
            collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
            let cell: HomeCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? HomeCollectionViewCell
        
        
            if let ttt = (self.spotListArray[indexPath.row] as! NSDictionary)["image_url"] as? String
            {
                cell.profileImg.sd_setImage(with: URL(string: (self.spotListArray[indexPath.row] as! NSDictionary)["image_url"] as! String), placeholderImage: UIImage(named:"bar.jpeg"), options: [], completed: nil)
            }
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        // let width = (UIScreen.main.bounds.width/2)-15
        
        return CGSize(width:(self.view.frame.width/3)-10, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
       
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let  spotDetailViewController = storyboard.instantiateViewController(withIdentifier: "SpotDetailViewController") as! SpotDetailViewController
        spotDetailViewController.spotDetailDict = (spotListArray[indexPath.row] as! NSDictionary)
        navigationController?.pushViewController(spotDetailViewController, animated: true)
        
        
    }
    
     // MARK: - ImagePicker Delegate
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
        
        profileImg.image = selectedImage
 
        imageData =  self.resizeImage(image: selectedImage)
        
        dismiss(animated: true, completion: nil)
        
        self.callProfileImageAction()
        
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
