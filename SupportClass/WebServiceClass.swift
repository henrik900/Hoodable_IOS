//
//  WebServiceClass.swift
//  ENEFrontend
//
//  Created by Ashwani Rajput on 8/22/17.
//  Copyright © 2017 Gomes. All rights reserved.
//  @objc optional func getServiceResponse(responseData:AnyObject)
//



import UIKit
import Foundation
import Alamofire
import SwiftyJSON

@objc protocol WebServiceDelegate {
    @objc optional func getServiceResponse(responseData:AnyObject, methodeString : String)
    @objc optional func getServiceError(errorDesc:String)
    
}



class WebServiceClass: NSObject {
    var parameterss = [String: Any]()

    var delegate: WebServiceDelegate?
    func callwebService(urlString:String, parameters:String, methodType:String) {

        let Url = "\(BaseURLS.baseURL)\(urlString)"

 
        let session = URLSession.shared
        
 
        // what is th purpose of URLSession.shared

        let urlPath = NSURL(string: Url)   // why use nsurl

        let request = NSMutableURLRequest(url: urlPath! as URL)
        request.timeoutInterval = 60

        request.httpMethod = methodType

        if methodType == "POST" {
              request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue( "Bearer \(String(describing: UserDefaults.standard.value(forKey: "token")))", forHTTPHeaderField: "Authorization")

            request.httpBody = parameters.data(using: String.Encoding.utf8) //jsonData
            
        }
        
        
        let dataTask = session.dataTask(with: request as URLRequest) {
            data, response, error -> Void in
            // self.hideNetworkActivity()
            if((error) != nil) {
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    self.delegate?.getServiceError!(errorDesc:error!.localizedDescription)      //To get error desc, if any
                }
            }
            else {
                let str = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
                 
                let _: NSError?
                
                let jsonResult: AnyObject = try! JSONSerialization.jsonObject(with:data!, options:JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                DispatchQueue.main.async {
                    self.delegate?.getServiceResponse!(responseData:jsonResult, methodeString : methodType)
                }
            }
        }
        dataTask.resume()
    }

    
    //MARK:-->> check url String rahul
    func canOpenURL(string: String?) -> Bool {
        guard let urlString = string else {return false}
        guard let url = NSURL(string: urlString) else {return false}
        if !UIApplication.shared.canOpenURL(url as URL) {return false}
        
        //
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    
    
    
    func callwebServicewithDict(urlString:String, parameters:Dictionary <String, Any>  , methodType:String) {
        
        let Url = "\(BaseURLS.baseURL)\(urlString)"
        
        let session = URLSession.shared        // what is th purpose of URLSession.shared
        
        let urlPath = NSURL(string: Url)   // why use nsurl
        
        let request = NSMutableURLRequest(url: urlPath! as URL)
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.httpMethod = methodType
 
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        
        if methodType == "POST" {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             request.setValue("application/json", forHTTPHeaderField: "Accept")

          
            request.httpBody = httpBody //jsonData
            
        }
        request.setValue( "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "")", forHTTPHeaderField: "Authorization")
 
        let dataTask = session.dataTask(with: request as URLRequest) {
            data, response, error -> Void in
            // self.hideNetworkActivity()
            if((error) != nil) {
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    self.delegate?.getServiceError!(errorDesc:error!.localizedDescription)
                    //To get error desc, if any
                }
            }
            else {
               // print("Succes:",request)
                let str = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
               // print("Webservice request response;",str as Any)
                let _: NSError?
                let jsonResult: AnyObject = try! JSONSerialization.jsonObject(with:data!, options:JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                DispatchQueue.main.async {
                    self.delegate?.getServiceResponse!(responseData:jsonResult, methodeString : urlString)
                }
            }
        }
        dataTask.resume()
    }
        
    func uploadVideoWebService(_ urlString: String,methodType:String, videoRecorded: String!, campaign_video_id: String, campaign_customer_id: String, customer_id: String, campaign_id: String, name: String, attempted: String, time_taken: String) {
        if videoRecorded == nil {
            return
        }
        
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url! as URL)
        let boundary = "------------------------14737809831466499882746641449"
        request.timeoutInterval = 60
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var movieData: NSData?
        do {
            movieData = try NSData(contentsOfFile: videoRecorded!, options: NSData.ReadingOptions.alwaysMapped)
        } catch _ {
            movieData = nil
            return
        }
        
        let body = NSMutableData()
        
        // change file name whatever you want
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"campaign_video_id\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(campaign_video_id)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"campaign_customer_id\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(campaign_customer_id)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"customer_id\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(customer_id)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"campaign_id\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(campaign_id)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(name)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"attempted\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(attempted)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"time_taken\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(time_taken)\r\n".data(using: String.Encoding.utf8)!)
        
        //        let filename = "upload.mov"
        //        let mimetype = "video/mov"
        let filename = "\(campaign_id).mp4"
        let mimetype = "video/mp4"
        //       let mimetype = "application/octet-stream"
        
        //        print("File size after compression: \(movieData!.length / 1048576) mb")
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: String.Encoding.utf8)!)
        //        body.append("Content-Disposition:form-data; name=\"file\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(movieData! as Data)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("\r\n--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody = body as Data
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            if((error) != nil) {
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    self.delegate?.getServiceError!(errorDesc:error!.localizedDescription)      //To get error desc, if any
                }
            }
            else {
                print("Succes:")
                let str = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
                print(str as Any)
                let _: NSError?
                let jsonResult: AnyObject = try! JSONSerialization.jsonObject(with:data!, options:JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                DispatchQueue.main.async {
                    self.delegate?.getServiceResponse!(responseData:jsonResult, methodeString : methodType)
                }
            }
        }
        task.resume()
    }
    
    //        pass_code, complaint_id, user_id, type(1=Text|2=Image|3=Video|4=Audio|5=File), message
    
    func callUploadImageWebService(methodType: String, imagename: String, image: UIImage) {
        
        let url = "\(BaseURLS.baseURL)\(methodType)"
        let urlPath = NSURL(string: url)
        let request = NSMutableURLRequest(url: urlPath! as URL)
        
        let boundary = "------------------------14737809831466499882746641449"
        request.timeoutInterval = 120
        request.httpMethod = "POST"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let body = NSMutableData()
        let mimetype = "image/png"
        let filename = "test.png"
 
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"event_image\"\r\n\r\n".data(using: String.Encoding.utf8)!)
 
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        
        body.append(image.pngData()!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("\r\n--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        
        
        
        
        request.httpBody = body as Data
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            if((error) != nil) {
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    self.delegate?.getServiceError!(errorDesc:error!.localizedDescription)
                }
            }
            else {
                print("Succes:")
                let str = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
                print(str as Any)
                let _: NSError?
                let jsonResult: AnyObject = try! JSONSerialization.jsonObject(with:data!, options:JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                DispatchQueue.main.async {
                    self.delegate?.getServiceResponse!(responseData:jsonResult, methodeString : methodType)
                }
            }
        }
        task.resume()
    }

    
    func callUploadOtherMediaService(urlString: String, methodType:String, request_id: String, type: String, mediaURL: String, mimeType: String, fileName: String) {
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url! as URL)
        
        let boundary = "------------------------14737809831466499882746641450"
        request.timeoutInterval = 60
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"request_id\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(request_id)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"type\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(type)\r\n".data(using: String.Encoding.utf8)!)
        
        var mediaData: NSData?
        do {
            mediaData = try NSData(contentsOfFile: mediaURL, options: NSData.ReadingOptions.alwaysMapped)
        } catch _ {
            mediaData = nil
            return
        }
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        print(fileName)
        body.append("Content-Disposition:form-data; name=\"message\"; filename=\"\(fileName)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(mediaData! as Data)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("\r\n--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody = body as Data
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            if((error) != nil) {
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    self.delegate?.getServiceError!(errorDesc:error!.localizedDescription)      //To get error desc, if any
                }
            }
            else {
                print("Succes:")
                let str = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
                print(str as Any)
                let _: NSError?
                let jsonResult: AnyObject = try! JSONSerialization.jsonObject(with:data!, options:JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                DispatchQueue.main.async {
                    self.delegate?.getServiceResponse!(responseData:jsonResult, methodeString : methodType)
                }
            }
        }
        task.resume()
    }
    
    
    func upload(params : [String: Any], imageData: Data, urlString: String ,imagenameParamter:String) {
        
        
        
            
            let headers1: HTTPHeaders = [
                
                "Content-type": "multipart/form-data",
 
            ]
      
        
       
 
        if let url = URL(string: "\(BaseURLS.baseURL)\(urlString)") {
            Alamofire.upload(
                multipartFormData: { (multipartdata) in
                    
                    multipartdata.append(
                        imageData,
                        withName: "\(imagenameParamter)",
                        fileName: "file.jpg",
                        mimeType: "image/png"
                    )
                    
                    for (key,value) in params {
                        if let data = value as? String,
                            let data1 = data.data(using: .utf8)
                        {
                            multipartdata.append(
                                data1,
                                withName: key
                            )
                        }
                    }
            },
                to: url,
                method: .post,
                headers: headers1,
                encodingCompletion: { (result) in
                    switch result {
                    case .success(let upload, _,_ ):
                        upload.responseJSON(completionHandler: { (response) in
                            
                            print("response",response)
                            if response.error != nil {
                                self.delegate?.getServiceError!(errorDesc:response.error!.localizedDescription)      //To get error desc, if any
                            } else {
                                print(response.result.value ?? "No data")
                                self.delegate?.getServiceResponse!(responseData:response.result.value as AnyObject, methodeString : urlString)

                            }
                        })
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
            }
            )
        }
        
    }
    
    
    
    func uploadProfile(params : [String: Any], imageData: Data, urlString: String ,imagenameParamter:String) {
        
        let headers1: HTTPHeaders = [
            
            "Content-type": "multipart/form-data",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "")"
            
        ]

        
        if let url = URL(string: "\(BaseURLS.baseURL)\(urlString)") {
            Alamofire.upload(
                multipartFormData: { (multipartdata) in
                    
                    multipartdata.append(
                        imageData,
                        withName: "\(imagenameParamter)",
                        fileName: "file.jpg",
                        mimeType: "image/png"
                    )
                    
                    for (key,value) in params {
                        if let data = value as? String,
                            let data1 = data.data(using: .utf8)
                        {
                            multipartdata.append(
                                data1,
                                withName: key
                            )
                        }
                    }
            },
                to: url,
                method: .post,
                headers: headers1,
                encodingCompletion: { (result) in
                    switch result {
                    case .success(let upload, _,_ ):
                        upload.responseJSON(completionHandler: { (response) in
                            
                            print("response",response)
                            if let err = response.error {
                                self.delegate?.getServiceError!(errorDesc:response.error!.localizedDescription)      //To get error desc, if any
                            } else {
                                print(response.result.value ?? "No data")
                                self.delegate?.getServiceResponse!(responseData:response.result.value as AnyObject, methodeString : urlString)
                                
                            }
                        })
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
            }
            )
        }
        
    }
    
}
