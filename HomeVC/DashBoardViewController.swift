//
//  DashBoardViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 04/02/20.
//  Copyright © 2020 Rustam Atabaev. All rights reserved.
//

import UIKit
import MapKit


class DashBoardViewController: UIViewController, KYButtonDelegate, WebServiceDelegate
{
    var artworks: [Artwork] = []
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    
    var spotListArray = Array<Any>()

    @IBOutlet weak var button: KYButton!

    
    @IBOutlet weak var addSpotBtn: UIButton!
  
   
    override func viewWillDisappear(_ animated: Bool) {
        
             // NotificationCenter.default.removeObserver(self)
    }
    
    func callSpotListAction()
    {
        AppDelegate.instance().addSpinLoaderView(show: true)
        
        let param = [
            "business_type_id" : "1"
            ] as Dictionary <String, String>
        
        let serviceClass = WebServiceClass()
        serviceClass.delegate = self
        serviceClass.callwebServicewithDict(urlString: API_Methods.method_spotlistAll, parameters:param, methodType: API_Methods.methodTypeGet)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
      
       button.isHidden = true
      
        self.callSpotListAction()

        if let ttt =  AppDelegate.instance().locationManager.location
        {
            centerMapOnLocation(location: AppDelegate.instance().locationManager.location!)

        }
        
        
        mapView.delegate = self
        mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
         NotificationCenter.default.addObserver(self, selector: #selector(DashBoardViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    func callThisForValidation()  {
        
        
         button.kyDelegate = self
        button.openType = .popUp
        button.plusColor = UIColor.white
        button.fabTitleColor = UIColor.white
    
        //   btn1.setFAIcon(icon: .FAUserO, iconSize: 30, forState: .normal)
        
        button.add(color:UIColor.clear, title: "New Spot", image: UIImage(named: "256-512.png")!){ (KYButtonCells) in
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "AddSpotViewController") as! AddSpotViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        
        if let dict = notification.userInfo as NSDictionary? {
            if let str_controler_name = dict["controlleraName"] as? String{
                if str_controler_name == "DashBoardVC" {
                    
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let  resetViewController = storyboard.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
                    self.navigationController?.pushViewController(resetViewController, animated: false)
                    
                    
                }
                else if str_controler_name == "HomeVC" {
                    
                    if  nil == (UserDefaults.standard.value(forKey: "id") as? NSInteger)
                    {
                        AppDelegate.instance().pushToLoginPage()

                    }
                    else
                    {
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let  resetViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        self.navigationController?.pushViewController(resetViewController, animated: false)
                    }
                  
                    
                }
                if str_controler_name == "SideMenuVC" {
                    
                   
                    AppDelegate.instance().showSideMenu(value: true)

                }
                else if str_controler_name == "SearchVC" {
                    
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let  resetViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
                    self.navigationController?.pushViewController(resetViewController, animated: false)
                    
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
                        self.navigationController?.pushViewController(resetViewController, animated: false)
                    }
                  
                }
            }
        }
    }
    
    @IBAction func backAction (_ sender : Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Web Service Delegates
    func getServiceResponse(responseData: AnyObject, methodeString: String) {
        let responseValue:NSDictionary = responseData as! NSDictionary
        print(responseValue)
        AppDelegate.instance().addSpinLoaderView(show: false)
        
        if methodeString == API_Methods.method_spotlistAll
        {
            if(responseValue["success"] as! Int == 0) {
                return;
            }
            var  localListArray = (responseValue["data"] as! NSArray) as! [Any]
            spotListArray = localListArray
            for item in localListArray
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
    
    
    func getServiceError(errorDesc: String) {
        AppDelegate.instance().addSpinLoaderView(show: false)
        AppDelegate.instance().showSingleActionAlert(titleName: "Alert", message: errorDesc)
        
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

extension DashBoardViewController: MKMapViewDelegate {
 
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
        spotDetailViewController.eventTypeString = location.discipline as NSString

        spotDetailViewController.spotDetailDict = indd
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
