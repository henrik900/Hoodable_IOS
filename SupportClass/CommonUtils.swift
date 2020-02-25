//
//  CommonUtils.swift
//  ENEFrontend
//
//  Created by Gautam Shrivastav on 8/22/17.
//  Copyright © 2017 Gomes. All rights reserved.
//

import UIKit

class CommonUtils: NSObject {
    class func getFlexibleHeight(_ height: CGFloat) -> CGFloat {
        let windowHeight: CGFloat? = AppDelegate.instance().window?.frame.size.height
        let ratio: CGFloat = windowHeight! / 667
        return ratio * height
    }
    
    class func getFlexibleWidth(_ width: CGFloat) -> CGFloat {
        let windowWidth: CGFloat? = AppDelegate.instance().window?.frame.size.width
        let ratio: CGFloat = windowWidth! / 375
        return ratio * width
    }
    
    class func nsStringIsValidEmail(_ checkString: String) -> Bool {
        let stricterFilter = true
        let stricterFilterString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let laxString = ".+@.+\\.[A-Za-z]{2}[A-Za-z]*"
        let emailRegex = stricterFilter ? stricterFilterString : laxString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: checkString)
    }
    
    class func nsStringIsValidDOB(_ checkString: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let inputDate: Date? = formatter.date(from: checkString)
        let startDate: Date? = formatter.date(from: "01/01/1900")
        //        formatter = nil
        if inputDate == nil {
            return false
        }
        else {
            if (inputDate?.compare(Date()) == .orderedDescending) || (startDate?.compare(inputDate!) == .orderedDescending) {
                return false
            }
            else {
                return true
            }
        }
    }
    
    class func checkIfMobile(_ mobileNum: String) -> Bool {
        let nf = NumberFormatter()
        let isDecimal: Bool? = nf.number(from: mobileNum) != nil
        return isDecimal!
    }
    
    class func getDeviceID() -> String {
        var deviceId: String = ""
        if (UIPasteboard(name: UIPasteboard.Name(rawValue: "UDID_PH"), create: false) != nil) {
            deviceId = (UIPasteboard(name: UIPasteboard.Name(rawValue: "UDID_PH"), create: false)?.string?.replacingOccurrences(of: "-", with: ""))!
        }
        else {
            //        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0) {
            //            deviceId = [[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
            //        }
            //        else{
            let theUUID: CFUUID = CFUUIDCreate(nil)
            let string: CFString = CFUUIDCreateString(nil, theUUID)
            deviceId = ((string as? String)?.replacingOccurrences(of: "-", with: ""))!
            //        }
            let pasteboard = UIPasteboard(name: UIPasteboard.Name(rawValue: "UDID_PH"), create: true)
            //        [pasteboard setPersistent:YES];
            pasteboard?.string = deviceId
        }
        return deviceId
    }
    
    class func getDeviceIDString() -> String {
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        return deviceID
    }
    
    //    class func formatNumber(_ mobileNumber: String) -> String {
    //        var mobileNum = mobileNumber
    //        mobileNum = mobileNumber.replacingOccurrences(of: "(", with: "")
    //        mobileNum = mobileNumber.replacingOccurrences(of: ")", with: "")
    //        mobileNum = mobileNumber.replacingOccurrences(of: " ", with: "")
    //        mobileNum = mobileNumber.replacingOccurrences(of: "-", with: "")
    //        mobileNum = mobileNumber.replacingOccurrences(of: "+", with: "")
    //        let length = Int(mobileNum.characters.count )
    //        if length > 10 {
    //            mobileNum = ((mobileNumber as? String)?.substring(from: length - 10))!
    //        }
    //        return mobileNum
    //    }
    //
    //    class func getLength(_ mobileNumber: String) -> Int {
    //        mobileNumber = mobileNumber.replacingOccurrences(of: "(", with: "")
    //        mobileNumber = mobileNumber.replacingOccurrences(of: ")", with: "")
    //        mobileNumber = mobileNumber.replacingOccurrences(of: " ", with: "")
    //        mobileNumber = mobileNumber.replacingOccurrences(of: "-", with: "")
    //        mobileNumber = mobileNumber.replacingOccurrences(of: "+", with: "")
    //        let length = Int(mobileNumber.characters.count ?? 0)
    //        return length
    //    }
    //
    //    class func formatDOB(_ dobNumber: String) -> String {
    //        dobNumber = dobNumber.replacingOccurrences(of: "/", with: "")
    //        let length = Int(dobNumber.characters.count ?? 0)
    //        if length > 8 {
    //            dobNumber = (dobNumber as? NSString)?.substring(from: length - 8)
    //        }
    //        return dobNumber
    //    }
    
    
    class func remove(_ key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    
    class func save(_ value: Any, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    class func getValue(_ key: String) -> Any {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: key)!
    }
    
    class func containsOnlyCharaters(_ string: String) -> Bool {
        let regex: String = "^[a-zA-Z _.-]+$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: string)
    }
    
    class func validatePinCode(_ numberString: String) -> Bool {
        if (numberString.count ) == 0 {
            return true
        }
        let regex: String = "[0-9]{5}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: numberString)
    }
    
    class func validateMobileNumber(_ numberString: String) -> Bool {
        if (numberString.count ) == 0 {
            return true
        }
        let regex: String = "[0-9]{10}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: numberString)
    }
    
    // MARK:null check..
    class func checkforNULLValue(inputString: Any) -> String {
        //        if inputString == NSNull() as? String {
        //            return ""
        //        }
        if((inputString as AnyObject).isKind(of:NSNull.self)){
            return ""
        }
        if inputString != nil && inputString != nil && !(inputString as! String == "(null)") && !(inputString as! String == "null") && !(inputString as! String == "<null>") && ((inputString as! String).count) > 0 && (inputString as! String != "nil")  {
            
            var strVal: String!
            strVal = inputString as! String
            strVal = strVal.replacingOccurrences(of: "Optional(\"", with: "")
            strVal = strVal.replacingOccurrences(of: "\")", with: "")
            return strVal
        }
        return ""
    }

    class func convertNull(value : AnyObject?) -> String {
        if value is NSNull {
            return ""
        } else {
            return value as! String
        }
    }
    
    class func isAlphaNumeric(_ str: String) -> Bool {
        let len = Int(str.count )
        var poinCount: Int = 0
        var singleCharacter: unichar
        for _ in 0..<len {
            singleCharacter = unichar(str.count)
            if singleCharacter == 0 || singleCharacter == 1 || singleCharacter == 2 || singleCharacter == 3 || singleCharacter == 4 || singleCharacter == 5 || singleCharacter == 6 || singleCharacter == 7 || singleCharacter == 8 || singleCharacter == 9 {
                poinCount += 1
            }
        }
        if poinCount >= 1 {
            return true
        }
        else {
            return false
        }
    }
    
    // MARK: - Calculate Dynamic Height For Label
    class func findDynamicHeightForlabelwithString(_ textString: String, for font: UIFont, for labelSize: CGSize) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraphStyle.alignment = .justified
        let dynamicSize: CGSize = textString.boundingRect(with: labelSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraphStyle], context: nil).size
        return dynamicSize
    }
    
    // MARK: - Set Font Methods
    class func getFontRegular(_ SizeOfFont: Int) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: CGFloat(SizeOfFont))!
    }
    
    class func getFontBold(_ SizeOfFont: Int) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: CGFloat(SizeOfFont))!
    }
    
    class func getFontMedium(_ SizeOfFont: Int) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: CGFloat(SizeOfFont))!
    }

    
    class func getFontRalewayRegular(_ SizeOfFont: Int) -> UIFont {
        return UIFont(name: "Raleway-Regular", size: CGFloat(SizeOfFont))!
    }
    
    // MARK: - Get Time Interval Between Two Dates
    class func getTimeInterValTillToday(fromDate dateString: String) -> String {
        //   var components: DateComponents?
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let fromDate: Date? = formatter.date(from: dateString) //[.day, .month, .year, .second, .minute, .hour, .weekOfMonth]
        //    NSDate *toDate = [formatter dateFromString:dateString];
        var components = Calendar.current.dateComponents([.day, .month, .year, .second, .minute, .hour, .weekOfMonth], from: fromDate!, to: Date())
        //      ver comp = Calendar.current.dateComponents(components: Set<Calendar.Component>, from: Date, to: Date)
        let year: Int? = components.year
        let month: Int? = components.month
        let week: Int? = components.weekOfMonth
        let day: Int? = components.day
        let hour: Int? = components.hour
        let minute: Int? = components.minute
        let second: Int? = components.second
        var daysAgo: String = ""
        if year! >= 1 {
            daysAgo = "\(Int(year!)) years ago"
            if year == 1 {
                daysAgo = "\(Int(year!)) year ago"
            }
        }
        else if month! >= 1 {
            daysAgo = "\(Int(month!)) months ago"
            if year == 1 {
                daysAgo = "\(Int(month!)) month ago"
            }
        }
        else if week! >= 1 {
            daysAgo = "\(Int(month!)) weeks ago"
            if year == 1 {
                daysAgo = "\(Int(month!)) week ago"
            }
        }
        else if day! >= 1 {
            daysAgo = "\(Int(day!)) days ago"
            if year == 1 {
                daysAgo = "\(Int(day!)) day ago"
            }
        }
        else if hour! >= 1 {
            daysAgo = "\(Int(hour!)) hours ago"
            if year == 1 {
                daysAgo = "\(Int(hour!)) hour ago"
            }
        }
        else if minute! >= 1 {
            daysAgo = "\(Int(minute!)) minutes ago"
            if year == 1 {
                daysAgo = "\(Int(minute!)) minute ago"
            }
        }
        else if second! > 0 {
            daysAgo = "Just now"
        }
        
        return daysAgo
    }
    
//    class func setAttributedTextWith(_ strText: String, with colorName: UIColor, with font: UIFont) -> NSMutableAttributedString {
//        let attribs: [AnyHashable: Any] = [NSAttributedStringKey.foregroundColor: colorName, NSAttributedStringKey.font: font, NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html]
//        let attributedText = try? NSMutableAttributedString(data: strText.data(using: String.Encoding.utf8)!, options: attribs as! [String : Any], documentAttributes: nil)
//        return attributedText!
//    }
    
    class func getAgeOfLoggedInUser(fromBirthDate dobString: String) -> String {
        var components: DateComponents?
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let fromDate: Date? = formatter.date(from: dobString)
        //    NSDate *toDate = [formatter dateFromString:dateString];
        components = Calendar.current.dateComponents([.day, .month, .year], from: fromDate!, to: Date())
        let year: Int? = components?.year
        let age: String = "\(Int(year!))"
        return age
    }
    
    func gradient(from c1: UIColor, to c2: UIColor, withHeight height: Int) -> UIColor {
        let size = CGSize(width: 1, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        let colorspace: CGColorSpace? = CGColorSpaceCreateDeviceRGB()
        let colors: [Any]? = [c1.cgColor, c2.cgColor]
        let gradient: CGGradient? = CGGradient(colorsSpace: colorspace, colors: (colors! as CFArray), locations: nil)
        context?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: [])
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image!)
    }
    
    class func viewShadow(viewName:UIView){
        viewName.layer.masksToBounds = false
        viewName.layer.shadowOffset = CGSize(width: 1, height: 1)
        viewName.layer.shadowRadius = 3
        viewName.layer.shadowOpacity = 0.4
    }
    
    class func convertDate(toStringFormat date: String) -> String {
        var convertedDate: String
        let dateFormatter = DateFormatter()
        if date.count > "yyyy-MM-dd".count {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        else {
            dateFormatter.dateFormat = "yyyy-MM-dd"
        }
        let dateSelected: Date? = dateFormatter.date(from: date)
        if dateSelected == nil {
            convertedDate = ""
        }
        else {
            dateFormatter.dateFormat = "MMM dd, yyyy"
            convertedDate = dateFormatter.string(from: dateSelected!)
        }
        return convertedDate
    }
    
    class func compareDates(dateValue: String) -> String {
        print(dateValue)
        var convertedDate: String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date1 = dateFormatter.date(from: dateValue)
        if date1 != nil {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date2 = dateFormatter.string(from: date1!)
            let dateToBeCompared = dateFormatter.date(from: date2)
            
            let currentDate = dateFormatter.string(from: Date())
            
            let currentDateToBeCompared = dateFormatter.date(from: currentDate)
            
            if dateToBeCompared ==  currentDateToBeCompared{
                dateFormatter.dateFormat = "HH:mm"
                convertedDate = dateFormatter.string(from: date1!)
            }
            else{
                dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
                convertedDate = dateFormatter.string(from: date1!)
            }
        }
        else {
            convertedDate = ""
        }
        return convertedDate
    }

    //MARK: - Convert To JSON String
    class func convertJSONToString(from object: Any) -> String? {
        if let objectData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions(rawValue: 0)) {
            let objectString = String(data: objectData, encoding: .utf8)
            return objectString
        }
        return nil
    }
    
    //MARK: - Convert To JSON Object
    class func convertStringToJSON(text: String) -> Any? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    class func resizeImage(image: UIImage) -> UIImage {
        let newWidth: CGFloat = 300
        let scale = 300 / image.size.width
        let newHeight = image.size.height * scale
        //        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        image.draw(in: CGRect(x:0, y:0, width:newWidth,  height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    class func getExtensionName(mediaType: Int, mediaPath: String) -> String {
        let mediaP = mediaPath.components(separatedBy: ".")
        print(mediaPath)
        print(mediaP)
        var extName = ""
        if mediaP.count > 0 {
            extName = mediaP[mediaP.count-1]
            print(extName)
        }
        //1=Text|2=Image|3=Video|4=Audio|5=File
        if extName.count < 3 {
            if mediaType == 2 {
                extName = "png"
            }
            else if mediaType == 3 {
                extName = "mp4"
            }
            else if mediaType == 4 {
                extName = "m4a"
            }
            else if mediaType == 5 {
                extName = "pdf"
            }
        }
        print(extName)
        return extName
    }
    
    class func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        
        //userKeyboardHeight = keyboardSize.cgRectValue.height
        
        return keyboardSize.cgRectValue.height
        
    }
    
    class func getCurrentDate() -> String {
        let dateS = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let convertedDate = dateFormatter.string(from: dateS)
        print(convertedDate)
        return convertedDate
    }

//    class func createNameImage(name: String, imageSize: CGFloat, imageView: UIImageView) {
//        let nameLabel = UILabel(frame: imageView.frame)
//
//        var initialLetters: String = ""
//        let separatedName = name.components(separatedBy: " ")
//        if separatedName.count > 1 {
//            initialLetters = "\(separatedName[0].first!)\(separatedName[separatedName.count-1].first!)"
//        }
//        else if separatedName.count > 0 {
//            initialLetters = "\(separatedName[0].first!)"
//        }
//        else {
//            initialLetters = "A"
//        }
//        nameLabel.text! = initialLetters
//
//        imageView.addSubview(nameLabel)
//    }
    
    class func createImageForName(name: String) -> UIImage{
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        imageView.setImage(string: name)
        return imageView.image!
    }
    
//    class func imageSnap(text: String?,
//                           color: UIColor,
//                           circular: Bool,
//                           textAttributes: [NSAttributedStringKey: Any]?, imageView: UIImageView) -> UIImage? {
//
//        let scale = Float(UIScreen.main.scale)
//        var size = imageView.bounds.size
//        if imageView.contentMode == .scaleToFill || imageView.contentMode == .scaleAspectFill || imageView.contentMode == .scaleAspectFit || imageView.contentMode == .redraw {
//            size.width = CGFloat(floorf((Float(size.width) * scale) / scale))
//            size.height = CGFloat(floorf((Float(size.height) * scale) / scale))
//        }
//
//        UIGraphicsBeginImageContextWithOptions(size, false, CGFloat(scale))
//        let context = UIGraphicsGetCurrentContext()
//        if circular {
//            let path = CGPath(ellipseIn: imageView.bounds, transform: nil)
//            context?.addPath(path)
//            context?.clip()
//        }
//
//        // Fill
//        context?.setFillColor(color.cgColor)
//        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
//
//        // Text
//        if let text = text {
//            let attributes = textAttributes ?? [NSAttributedStringKey.foregroundColor: UIColor.white,
//                                                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0)]
//
//            let textSize = text.size(withAttributes: attributes)
//            let bounds = imageView.bounds
//            let rect = CGRect(x: bounds.size.width/2 - textSize.width/2, y: bounds.size.height/2 - textSize.height/2, width: textSize.width, height: textSize.height)
//
//            text.draw(in: rect, withAttributes: attributes)
//        }
//
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return image
//    }
    
    class func getAgeOfUser(birthDateStr: String) -> String {
        let startDate = birthDateStr
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"//"yyyy-MM-dd"
        let formatedStartDate = dateFormatter.date(from: startDate)
        
        if formatedStartDate == nil {
            return ""
        }
        else {
            let currentDate = Date()
            //   let components = Set<Calendar.Component>([.second, .minute, .hour, .day, .month, .year])
            let components = Set<Calendar.Component>([.year])
            
            let differenceOfDate = Calendar.current.dateComponents(components, from: formatedStartDate!, to: currentDate)
            
            print (differenceOfDate)
            return "\(differenceOfDate.year!)"
        }
    }


}
