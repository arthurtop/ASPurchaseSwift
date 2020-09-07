//
//  CommonExtension.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/22.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import Foundation


extension String {
    
    func color() -> UIColor {
        var cString: String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if cString.count < 6 {
            return UIColor.black
        }
        if cString.hasPrefix("0X") {
            cString = String(cString.suffix(from: cString.index(cString.startIndex, offsetBy: 2)))
        }
        if cString.hasPrefix("#") {
            cString = String(cString.suffix(from: cString.index(cString.startIndex, offsetBy: 1)))
        }
        if cString.count != 6 {return UIColor.black}
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
    }
    
//    func toNSRange(_ range: Range<String.Index>) -> NSRange {
//        guard let from = range.lowerBound.samePosition(in: utf16), let to = range.upperBound.samePosition(in: utf16) else {
//            return NSMakeRange(0, 0)
//        }
//        return NSMakeRange(utf16.distance(from: utf16.startIndex, to: from), utf16.distance(from: from, to: to))
//    }
    
    func toNSRange(from range: Range<Index>) -> NSRange {
        return .init(range, in: self)
    }
    
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        return from ..< to
    }
    
    func isIncludeChineseIn() -> Bool {
        for value in self {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    // 随机生成数字、字母字符串
    static func random(_ count:Int) -> String {
        let source = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z"
        let array = source.components(separatedBy: ",")
        var mstr = ""
        for _ in 0 ..< count {
            let index = Int(arc4random())%array.count
            mstr += array[index]
        }
        return mstr.lowercased()
    }
    
    func deleteSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func auto(_ size:CGSize,_ font:UIFont) -> CGSize {
        let attributes:Dictionary<NSAttributedString.Key,Any> = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let text:NSString = self as NSString
        return text.boundingRect(with: size, options: option, attributes: attributes, context: nil).size
    }
    
    var intValue:Int {
        get {
            return Int(self) ?? 0
        }
    }
    
    var floatValue:Float {
        get {
            return Float(self) ?? 0
        }
    }
    
    var isNum:Bool {
        get {
            if self.isEmpty {
                return false
            }
            let whitespace = CharacterSet.whitespaces
            let tem = self.trimmingCharacters(in: whitespace)
            let pred = NSPredicate(format: "SELF MATCHES '^[0-9]*$'")
            return pred.evaluate(with: tem)
        }
    }
    
    var isPhone:Bool {
        get {
            if self.count == 11 && self.isNum {
                return true
            }
            return false
        }
    }
    
    var isEmail:Bool {
        get {
            let predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
            return predicate.evaluate(with: self)
        }
    }
    
    var isPriceType:Bool {
        get {
            if self.isEmpty {
                return false
            }
            let whitespace = CharacterSet.whitespaces
            let tem = self.trimmingCharacters(in: whitespace)
            let pred = NSPredicate(format: "SELF MATCHES '^[0-9]{1,8}([.][0-9]{1,5})?$'")
            return pred.evaluate(with: tem)
        }
    }
    
    func deleteLineFeed() -> String {
        return self.replacingOccurrences(of: "\n", with: " ").replacingOccurrences(of: "\r", with: " ")
    }
    
    // position 0 为前 1为后 2为前后 content 为要添加的内容
    func add(position:Int,content:String,count:Int = 1) -> String {
        var pre = ""
        var suf = ""
        switch position {
        case 0:
            for _ in 0 ..< count {
                pre += content
            }
            break
        case 1:
            for _ in 0 ..< count {
                suf += content
            }
            break
        case 2:
            for _ in 0 ..< count {
                pre += content
                suf += content
            }
            break
        default:
            break
        }
        return pre + self + suf
    }
    
    func urlEncode() -> String {
//        !*'();:@&=+$,/?%#[]<>
        let mstring = self.replacingOccurrences(of: " ", with: "+")
        let charactersToEscape = "!*'\"();:@&=+$,/?%#[]% "
        let allowedCharacters = CharacterSet.init(charactersIn: charactersToEscape).inverted
        return mstring.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? self
    }
    
    func urlDecode() -> String {
        return self.removingPercentEncoding ?? self
    }
    /*
    //MARK: - MD5
    var md5:String {
        get {
            guard let cStr = self.cString(using: String.Encoding.utf8) else {
//                DLog("!!!!!!!!!md5失败了!!!!!!!!!")
                return self
            }
            let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
            CC_MD5(cStr,(CC_LONG)(strlen(cStr)), buffer)
            let md5String = NSMutableString();
            for i in 0 ..< 16 {
                md5String.appendFormat("%02x", buffer[i])
            }
            free(buffer)
            return md5String as String
        }
    }
 */
    //MARK: - sha1 加密
    /*
    var sha1:String {
        get {
            guard let data = self.data(using: String.Encoding.utf8, allowLossyConversion: true) else {
//                DLog("!!!!!!!!!sha1失败了!!!!!!!!!")
                return self
            }
            var digest = [UInt8](repeating:0,count:Int(CC_SHA1_DIGEST_LENGTH))
            //CC_SHA1(data.bytes, CC_LONG(data.count), &digest)
            _ = data.withUnsafeBytes { bytes in
                CC_SHA1(bytes, CC_LONG(data.count), &digest)
            }
            let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
            for byte in digest {
                output.appendFormat("%02x", byte)
            }
            return output as String
        }
    }
    */
    
    var xor:String {
        get {
            guard let buffer = (self as NSString).utf8String else {
                return self
            }
            let length = Int(strlen(buffer))
            let dst = UnsafeMutablePointer<Int8>.allocate(capacity: length + 1)
            dst[length] = 0
            for i in 0 ..< length {
                dst[i] = buffer[i] ^ Int8(9)
            }
//            // 再做一次进行校验，是否为原字符串
//            for i in 0 ..< length {
//                dst[i] ^= Int8(9)
//            }
            let xor = NSString(utf8String: dst) ?? ""
            free(dst)
            return xor as String
        }
    }
    
}

//时间操作extension
extension String {
    
    static func dateToDetailString() ->String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    static func dateToYMString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    static func dateToString() ->String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    static func dateToString(date:Date) ->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    static func dateYearToString(date:Date) ->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    static func dateMonthToString(date:Date) ->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    static func getYesterdayTime()->String{
        let date = Date().addingTimeInterval(-60*60*24)
        let dateForm = DateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd"
        let dateString = dateForm.string(from: date)
        return dateString
    }
    
    func timeStamp(_ formatter:String) -> String {
        if self.isEmpty || formatter.isEmpty {
            return ""
        }
        let dateForm = DateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd"
        let date = dateForm.date(from: self)
        return String(format: "%d", Int(date?.timeIntervalSince1970 ?? 0))
    }
    
    func switchDayA() -> String {
        if self.isEmpty {
            return ""
        }
        var dateForm = DateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateForm.date(from: self)
        dateForm = DateFormatter()
        dateForm.dateFormat = "MM-dd"
        return dateForm.string(from: date ?? Date())
    }
    
    func parseTime(_ formatter:String,_ toformatter:String) -> String {
        if formatter.isEmpty || toformatter.isEmpty {
            return self
        }
        var dateForm = DateFormatter()
        dateForm.dateFormat = formatter
        if let date = dateForm.date(from: self) {
            dateForm = DateFormatter()
            dateForm.dateFormat = toformatter
            return dateForm.string(from: date)
        }
        return self
    }
    
    // 不满几位高位补x
    func highPrositionInsert(_ count:Int,_ val:String = "0") -> String {
        var temp = self
        while temp.count < count {
            temp = val + temp
        }
        return temp
    }
    
    static var timeStamp:String {
        get {
            return String(format: "%.0f", Date().timeIntervalSince1970)
        }
    }
    
    var object:Any? {
        get {
            var object:Any?
            if let data = self.data(using: .utf8) {
                do {
                    object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                } catch {
//                    DLog("string parse object error !!")
                }
            }
            return object
        }
    }
    
    var isThreeDays:Bool {
        let dateForm = DateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateForm.date(from: self) {
            let creatTime = date.timeIntervalSince1970
            let currentTime = Date().timeIntervalSince1970
            return currentTime - creatTime < 72*60*60
        }
        return false
    }
    
    
}

extension String {
    //从下标为0开始取到index位置的子串
    func subString(to index: Int) -> String {
        if index >= self.count {
            return self
        }
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    //从下标为index取到结尾的子串
    func subString(from index: Int) -> String {
        if index >= self.count {
            return ""
        }
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    //从下标为index取长度为subLength子串
    func subString(from index: Int,length subLength: Int) -> String {
        if index >= self.count {
            return ""
        }
        if index + subLength > self.count {
            return self.subString(from: index)
        }
        let start = self.index(startIndex, offsetBy:index)
        let end = self.index(start, offsetBy:subLength)
        return String(self[start ..< end])
    }
    
    func jsonObject() -> [String:Any] {
        var dic = [String:Any]()
        guard let data = self.data(using: .utf8) else {
            return dic
        }
        do {
            let data = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            dic = data as? [String:Any] ?? [String:Any]()
        } catch _ {
//            DLog("jsonString parse error !!")
        }
        return dic
    }
    
}

extension NSMutableAttributedString {
    func auto(_ size:CGSize,_ font:UIFont) -> CGSize {
        let option : NSStringDrawingOptions = [NSStringDrawingOptions.usesLineFragmentOrigin]
        return self.boundingRect(with: size, options: option, context: nil).size
    }
}

extension Dictionary {
    func jsonString() -> String {
        if JSONSerialization.isValidJSONObject(self) {
            do {
                let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
                let string = String(data: data, encoding: .utf8) ?? ""
                let string1 = string.replacingOccurrences(of: "\n", with: "")
                let string3 = string1.replacingOccurrences(of: "\\", with: "")
                return string3
            } catch _ {
//                DLog("jsonString parse error !!")
            }
        }
        return "{}"
    }
}

extension Array {
    func jsonString() -> String {
        if JSONSerialization.isValidJSONObject(self) {
            do {
                let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
                let string = String(data: data, encoding: .utf8) ?? ""
                let string1 = string.replacingOccurrences(of: "\n", with: "")
                let string3 = string1.replacingOccurrences(of: "\\", with: "")
                return string3
            } catch _ {
//                DLog("jsonString parse error !!")
            }
        }
        return "[]"
    }
}

extension NSCoder {
    
    func decodeString(_ forKey:String,_ value:String = "") -> String {
        if forKey.isEmpty {
            return value
        }
        return self.decodeObject(forKey: forKey) as? String ?? value
    }
    
    func decodeArray<T>(_ forKey:String,_ value:Array<T> = Array<T>()) -> Array<T> {
        if forKey.isEmpty {
            return value
        }
        return self.decodeObject(forKey: forKey) as? Array<T> ?? value
    }
}


extension UIView {
    
    func clear() {
        for sub in self.subviews {
            sub.removeFromSuperview()
        }
    }

    func barButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(customView: self)
    }
    
}

extension UITableView {
    func setTabBehavior() {
        self.tableFooterView = UIView()
        self.backgroundColor = k_F5F5F5
        self.separatorStyle = .none
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }
}

extension UIButton {
    
}

extension UITextField {
    
    func setAttributed(_ placeholder:String,_ tintColor:UIColor,_ clearButtonMode:UITextField.ViewMode,_ returnKeyType:UIReturnKeyType,_ isSecureTextEntry:Bool,_ keyboardType:UIKeyboardType) {
        self.placeholder = placeholder
        self.tintColor = tintColor
        self.clearButtonMode = clearButtonMode
        self.returnKeyType = returnKeyType
        self.isSecureTextEntry = isSecureTextEntry
        self.keyboardType = keyboardType
    }
}

extension UIButton {
  
    func setAttribute(title:String,font:UIFont,textColor:UIColor,_ textAlignment:NSTextAlignment = .left) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = font
        self.titleLabel?.textAlignment = textAlignment
    }
    
    func imageRight(_ space:CGFloat) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.001) {
            let img_width = self.imageView?.frame.size.width ?? 0
            let tit_width = self.titleLabel?.frame.size.width ?? 0
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -img_width - space, bottom: 0, right: img_width + space)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: tit_width + space, bottom: 0, right: -tit_width - space)
        }
    }
    
    func imageTop(_ space:CGFloat) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.001) {
            let img_width = self.imageView?.frame.size.width ?? 0
            let img_height = self.imageView?.frame.size.height ?? 0
            let tit_width = self.titleLabel?.frame.size.width ?? 0
            let tit_height = self.titleLabel?.frame.size.height ?? 0
            self.titleEdgeInsets = UIEdgeInsets(top:     (tit_height / 2 + space / 2),
                                                left:   -(img_width / 2),
                                                bottom: -(tit_height / 2 + space / 2),
                                                right:   (img_width / 2))
            self.imageEdgeInsets = UIEdgeInsets(top:    -(img_height / 2 + space / 2),
                                                left:    tit_width/2,
                                                bottom:  (img_height / 2 + space / 2),
                                                right:  -(tit_width/2))
        }
    }
    
    func imageReset() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.001) {
            self.titleEdgeInsets = UIEdgeInsets.zero
            self.imageEdgeInsets = UIEdgeInsets.zero
        }
    }
}

extension UILabel {
    func setAttribute(title:String,font:UIFont,textColor:UIColor,_ textAlignment:NSTextAlignment = .center) {
        self.text = title
        self.textAlignment = textAlignment
        self.font = font
        self.textColor = textColor
    }
}

extension UIImage {
    
    //颜色生成图片
    func createImage(_ color: UIColor)-> UIImage{
        let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    func gray() -> UIImage {
        let imageW = self.size.width
        let imageH = self.size.height
        let colorSpace = CGColorSpaceCreateDeviceGray()
        guard let context = CGContext(data: nil, width: Int(imageW) , height: Int(imageH), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue) else {
            return self
        }
        guard let cgimg = self.cgImage else {
            return self
        }
        context.draw(cgimg, in: CGRect.init(x: 0, y: 0, width: imageW, height: imageH))
        
        guard let ciimg = context.makeImage() else {
            return self
        }
        return UIImage(cgImage: ciimg)
    }
    
    
}

extension UIView {
    
    func gray(_ cor:CGFloat = 0) {
        if !hasValue(viewWithTag(198760)) {
            let v = UIView(frame: bounds)
            v.tag = 198760
            v.layer.cornerRadius = cor
            v.layer.masksToBounds = true
            v.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
            addSubview(v)
        }
    }
    
    func removeGray() {
        viewWithTag(198760)?.removeFromSuperview()
    }
}

