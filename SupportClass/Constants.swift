//
//  Constants.swift
//  SJSGDocs
//
//  Created by Ketaki on 23/01/19.
//  Copyright © 2019 ITC Infotech. All rights reserved.
//

import UIKit


    struct BaseURLS {
 
        static let baseURL: String = "http://server.hoodable.tk/api/v1/"

    }
    
    //MARK: - API Names
    struct API_Methods {
        static let methodTypePost: String = "POST"
        static let methodTypeGet: String = "GET"
        static let method_login: String = "auth/login"
        static let method_signup: String = "auth/signup"
        static let method_upgradeRequest: String = "user/upgradeRequest"
        static let method_userUpgrade: String = "user/upgrade"

 
        static let method_categorylist: String = "category/list"
        static let method_businesslist: String = "business/list"
        static let method_spotlist: String = "spot/list"
        static let method_spotlistAll: String = "spot/spotList"

        static let method_addspot: String = "spot/create"
        static let method_addevent: String = "event/create"
        static let method_addpromotion: String = "event/create"
        static let method_addcompitition: String = "event/create"
        
        static let method_uploadmedia: String = "upload/image"
        static let method_uploadprofile: String = "user/updateProfileImage"


        

    }



    struct AlertConstants {
        static let INVALID_PASSWORD = "Invalid Password"
        static let INVALID_USERNAME = "Invalid User name"
        static let NO_DATA_AVAILABLE = "No data available"
        static let USER_NOT_FOUND = "Invalid Credentails"
     
        static let YES = "Yes"
        static let NO = "No"
        static let OK = "Ok"
    }

