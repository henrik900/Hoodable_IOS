/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String
  let discipline: String
    let idString: String

  let coordinate: CLLocationCoordinate2D

  init(title: String, idString: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate
    self.idString = idString
    super.init()
  }

  init?(json: [Any]) {
    // 1
    
    let localDictValue = json[0] as! NSDictionary
    let  componentArray =  localDictValue.allKeys as! Array<String> // for Dictionary
    
    var check = false
    for item in componentArray
    {
        if item == "spot_name"
        {
            check = true
            break
        }
    }
    
    if check == true
    {
        self.title = (localDictValue.value(forKey: "spot_name") as! String).capitalized
        self.locationName = localDictValue.value(forKey: "spot_description") as! String
        self.discipline = "\(localDictValue.value(forKey: "business_type_id") as? NSString)"
        self.idString = "\(localDictValue.value(forKey: "id") as! Int)"
    }
    else
    {
        self.title = (localDictValue.value(forKey: "name") as! String).capitalized
        self.locationName = localDictValue.value(forKey: "description") as! String
        self.discipline = "\(localDictValue.value(forKey: "event_type") as! NSString)"
        self.idString = "\(localDictValue.value(forKey: "id") as! Int)"
    }
 
    
     // 2
    let latitude = Double(localDictValue.value(forKey: "latitude") as! String)
      let longitude = Double(localDictValue.value(forKey: "longitude") as! String)
    self.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
     
  }

    
  var subtitle: String? {
    return locationName
  }

  // pinTintColor for disciplines: Sculpture, Plaque, Mural, Monument, other
  var markerTintColor: UIColor  {
    switch discipline {
    case "Events":
      return .red
    case "Business":
      return .blue
    case "Place":
      return .green
    case "Sculpture":
      return .purple
    default:
      return .green
    }
  }

  var imageName: String? {
    if discipline == "Business" { return "256-512.png" }
    return "256-512.png"
  }

    
  // Annotation right callout accessory opens this mapItem in Maps app
  func mapItem() -> MKMapItem {
    let addressDict = [CNPostalAddressStreetKey: subtitle!]
    let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = title
    return mapItem
  }

}


