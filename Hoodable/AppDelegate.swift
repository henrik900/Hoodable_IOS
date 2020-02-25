//
//  AppDelegate.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 16/12/19.
//  Copyright © 2019 Rustam Atabaev. All rights reserved.
//


import UIKit
import IQKeyboardManagerSwift
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {

    var window: UIWindow?
     var navigationController: UINavigationController?
    var loginViewController : LoginViewController?
    var addSpotViewController : AddSpotViewController?
    var spinnLoader: SpinLoader?
    var sideMenuView: SideMenuView?
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    var isUpdatingLocation: Bool = false
    var pickUpLatitudeVal: String = ""
    var pickUpLongitudeVal: String = ""
    var pickUpAddressString: String = ""
 
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        IQKeyboardManager.shared.enable = true
        
        
        
        self.pushToHomePage()
       
        self.getMyLocation()
        
        self.window?.makeKeyAndVisible()
        self.navigationController?.isNavigationBarHidden = true
        

        return true
    }
    
    // MARK: User Defined Methods
    class func instance() -> AppDelegate {
        return (UIApplication.shared.delegate! as! AppDelegate)
    }
    
    
    func pushToLoginPage()
    {
        if !(loginViewController != nil) {
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let  homeViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
        else {
            var viewController: [Any]? = navigationController?.viewControllers
            for controller: Any in viewController! {
                if (controller is LoginViewController) {
                    navigationController?.popToViewController(controller as! UIViewController, animated: true)
                    viewController = nil
                    return
                }
            }
            self.navigationController?.pushViewController(loginViewController!, animated: true)
            self.navigationController?.isNavigationBarHidden = true

        }
    }
    
    
    func pushToHomePage(){
 
        if (UserDefaults.standard.value(forKey: "id")) != nil
        {
            if UserDefaults.standard.value(forKey: "user_type") as! String == "1"
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let  addSpotViewController = storyboard.instantiateViewController(withIdentifier: "AddSpotViewController") as! AddSpotViewController
                self.navigationController = UINavigationController(rootViewController:addSpotViewController)
                self.window?.rootViewController = self.navigationController
            }
            else
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let  addSpotViewController = storyboard.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
                self.navigationController = UINavigationController(rootViewController:addSpotViewController)
                self.window?.rootViewController = self.navigationController
            }
        }
        else
        {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let  addSpotViewController = storyboard.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
            self.navigationController = UINavigationController(rootViewController:addSpotViewController)
            self.window?.rootViewController = self.navigationController
        }
        self.navigationController?.isNavigationBarHidden = true

    }
    
    
    
    func showSideMenu(value: Bool) {
        if value == true {
            if sideMenuView == nil {
                sideMenuView = SideMenuView(frame: CGRect(x: 0, y: 0, width: CommonUtils.getFlexibleWidth(375), height: CommonUtils.getFlexibleHeight(667)))
                self.navigationController?.view.addSubview(sideMenuView!)
            }
            UIView.animate(withDuration: 0.25, animations: {
                var frame: CGRect = self.sideMenuView!.sideTableView.frame
                frame.origin.x = 0
                self.sideMenuView?.sideTableView.frame = frame
                self.sideMenuView?.hideMenuButton.alpha = 0.6
            }, completion: { (finished) -> Void in
            })
        }
        else {
            if sideMenuView != nil {
                UIView.animate(withDuration: 0.25, animations: {
                    var frame: CGRect = self.sideMenuView!.sideTableView.frame
                    frame.origin.x = -248
                    self.sideMenuView?.sideTableView.frame = frame
                    self.sideMenuView?.hideMenuButton.alpha = 0
                }, completion: { (finished) -> Void in
                    self.sideMenuView?.removeFromSuperview()
                    self.sideMenuView = nil
                })
            }
        }
    }
    
    
    func onClickOfSideMenuOptons(indexNo: Int) {
        if indexNo == 0 {
            
          self.pushToHomePage()
        }
        else if indexNo == 1 {
            
            if  nil == (UserDefaults.standard.value(forKey: "id") as? NSInteger)
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let  resetViewController = storyboard.instantiateViewController(withIdentifier: "AgentRegisterViewController") as! AgentRegisterViewController
                navigationController?.pushViewController(resetViewController, animated: false)
            }
            else
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let  resetViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                navigationController?.pushViewController(resetViewController, animated: false)
            }
        }
        else if indexNo == 2 {
            
            
        }
        else if indexNo == 3 {
            
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
        else if indexNo == 4 {
            
            if  nil == (UserDefaults.standard.value(forKey: "id") as? NSInteger)
            {
                AppDelegate.instance().pushToLoginPage()
            }
            else
            {
                let alert = UIAlertController(title: "", message: "Are you sure, you want to logout?", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                    alert.dismiss(animated: true, completion: nil)
                })
                alert.addAction(okAction)
                let otherAction = UIAlertAction(title: "Okay", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                  
                    UserDefaults.standard.set(nil, forKey: "id")
                    AppDelegate.instance().pushToHomePage()

 
                })
                alert.addAction(otherAction)
                navigationController?.present(alert, animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    
    
    
    func addSpinLoaderView(show: Bool) {
        if show == true {
            spinnLoader = SpinLoader.init(frame:CGRect(x: 0, y: 0, width: CommonUtils.getFlexibleWidth(375), height: CommonUtils.getFlexibleHeight(667)))
            self.window?.addSubview(spinnLoader!)
        }
        else {
            spinnLoader!.removeFromSuperview()
        }
    }
    
    
    // MARK: - Alert Controller
    func showSingleActionAlert(titleName: String, message: String) {
        let alert = UIAlertController(title: titleName, message: message, preferredStyle: .alert)
        
        let otherAction = UIAlertAction(title: "Okay", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            // Other action
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(otherAction)
        navigationController?.present(alert, animated: true, completion: nil)
    }

    
    func getMyLocation() {
        //Get user's permission to use location services
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        //start stop finding location
        if self.isUpdatingLocation == true {
            stopUpdatingLocation()
        }
        else {
            startUpdatingLocation()
        }
        updateLocationInformation()
        
        
        if authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        //report to user if permission is denied (1)User refused (2)Device restricted
        if authorizationStatus == .denied || authorizationStatus == .restricted {
            reportLocationError()
            return
        }
        
     
    }

    
    
    func updateLocationInformation() {
        if let location = startLocation {
            self.pickUpLatitudeVal = "\(location.coordinate.latitude)"
            self.pickUpLongitudeVal = "\(location.coordinate.longitude)"
            
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarksArray, error) in
                if (placemarksArray != nil) {
                    self.pickUpAddressString = ""
                    
                    let placemark = placemarksArray?.first
                    let addressDict = placemark?.addressDictionary
                    
                    //                    if let name = addressDict!["name"] as? String {
                    //                        self.pickUpAddressString.append(contentsOf: "\(name)")
                    //                    }
                    
                    if let street = addressDict!["Street"] as? String {
                        self.pickUpAddressString.append(contentsOf: "\(street), ")
                    }
                    
                    if let subLocality = addressDict!["SubLocality"] as? String {
                        self.pickUpAddressString.append(contentsOf: "\(subLocality), ")
                    }
                    
                    if let city = addressDict!["City"] as? String {
                        self.pickUpAddressString.append(contentsOf: "\(city), ")
                    }
                    
                    if let state = addressDict!["State"] as? String {
                        self.pickUpAddressString.append(contentsOf: "\(state), ")
                        //                        self.currentStateName = "\(state)"
                    }
                    
                    if let country = addressDict!["Country"] as? String {
                        self.pickUpAddressString.append(contentsOf: "\(country), ")
                    }
                    
                    if let zipCode = addressDict!["ZIP"] as? String {
                        self.pickUpAddressString.append(contentsOf: "\(zipCode)")
                    }
                    
                    //                    self.pickUpTextField.text = "\(self.pickUpAddressString)"
                }
            }
        }
        else {
        }
    }
    
    
    func reportLocationError() {
        //        let alert = UIAlertController(title: "Oops! Location services disabled", message: "Please go to Settings > Privacy to enable location.", preferredStyle: .alert)
        //        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        //        alert.addAction(okayAction)
        //        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func startUpdatingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            isUpdatingLocation = true
        }
    }
    
    func stopUpdatingLocation() {
        if isUpdatingLocation == true {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            isUpdatingLocation = false
        }
    }
    
    //MARK: - CoreLocation Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //   let location:CLLocation = locations[locations.count-1]
        //        self.latitudeVal = "\(location.coordinate.latitude)"
        //        self.longitudeVal = "\(location.coordinate.longitude)"
        
        startLocation = locations.last
        print("Got location - \(String(describing: startLocation))")
        
        stopUpdatingLocation()
        updateLocationInformation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Can't get your location!")
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
        stopUpdatingLocation()
        updateLocationInformation()
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    


}

