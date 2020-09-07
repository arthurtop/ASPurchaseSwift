//
//  ASCommon.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/22.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import Foundation
import AdSupport
import SwiftyJSON


let k_version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String // 版本号

let k_screen_width:CGFloat = UIScreen.main.bounds.width

let k_screen_height:CGFloat = UIScreen.main.bounds.height

let k_key_window = UIApplication.shared.keyWindow!

let k_statusbar_height:CGFloat = { // 状态栏高度
    var height:CGFloat = 20.0
    if iOS.isIphoneXLater {
        height = 44.0
    }
    return height
}()

let k_navbar_hegiht:CGFloat = { // 导航条高度(包含了状态的高度)
    var height:CGFloat = 64.0
    if iOS.isIphoneXLater {
        height = 88.0
    }
    return height
}()

let k_navbar_v_hegiht:CGFloat = { // 导航条高度(包含了状态的高度)
    var height:CGFloat = 44.0
    if iOS.isIphoneXLater {
        height = 88.0
    }
    return height
}()

let k_tabbar_hegiht:CGFloat = { // 底部tabbar高度
    var height:CGFloat = 49.0
    if iOS.isIphoneXLater {
        height = 81.0
    }
    return height
}()

let k_view_height:CGFloat = { // 页面不包括导航条高但包括底部tabbar高度
    var height:CGFloat = k_screen_height - k_navbar_hegiht
    return height
}()

let k_view_height_t:CGFloat = k_screen_height - k_navbar_hegiht - k_tabbar_hegiht  // 页面不包括导航条高也不包括底部tabbar高度

let k_safearea_bottom:CGFloat = {
    var height:CGFloat = 0.0
    if iOS.isIphoneXLater {
        height = 34.0
    }
    return height
}()

func hasValue<T>(_ val:T?) -> Bool {
    if val == nil {
        return false
    }
    return true
}

func Localized(_ t:String) -> String {
    return NSLocalizedString(t, comment: "")
}

var User = ASUserCenter.shared.user ?? UserModel()

let k_delegate = UIApplication.shared.delegate as! AppDelegate

// 获取BundleId
let k_bundle_id = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String ?? ""
// 99美元BundleId
let k_company_id = "cn.ubox.ubake"

struct iOS {
    static let bundleVerion:String = {
        var ver = k_version
        let bv = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
        if let bvs = bv as? String {
            ver = bvs
        }
        return ver
    }()
    
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
    
    static let isPhone4: Bool = {
        var isConfirm = false
        if k_screen_height == 480.0 {
            isConfirm = true
        }
        return isConfirm
    }()
    
    static let isPhone5: Bool = {
        var isConfirm = false
        if k_screen_height == 568.0 {
            isConfirm = true
        }
        return isConfirm
    }()
    
    static let isPhone6: Bool = {
        var isConfirm = false
        if k_screen_height == 667.0 {
            isConfirm = true
        }
        return isConfirm
    }()
    
    static let isPhone6p: Bool = {
        var isConfirm = false
        if k_screen_height == 736.0 {
            isConfirm = true
        }
        return isConfirm
    }()
    
    static let isIphoneXLater:Bool = {
        var isConfirm = false
        if k_screen_height >= 812.0 {
            isConfirm = true
        }
        return isConfirm
    }()
    
    static let isPhoneX: Bool = {
        var isConfirm = false
        if UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) {
            isConfirm = CGSize(width:1125, height:2436).equalTo(UIScreen.main.currentMode!.size)
        }
        return isConfirm
    }()
    
    static let isPhoneXR: Bool = {
        var isConfirm = false
        if UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) {
            isConfirm = CGSize(width:1242, height:2688).equalTo(UIScreen.main.currentMode!.size)
        }
        return isConfirm
    }()
    //414 896
    static let isPhoneXS_Max: Bool = {
        var isConfirm = false
        if UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) {
            isConfirm = CGSize(width:1242, height:2688).equalTo(UIScreen.main.currentMode!.size)
        }
        return isConfirm
    }()
    
    static let modelString:String = {
        if let key = "hw.machine".cString(using: String.Encoding.utf8) {
            var size: Int = 0
            sysctlbyname(key, nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: Int(size))
            sysctlbyname(key, &machine, &size, nil, 0)
            return String(cString: machine)
        }
        return ""
    }()
    
    static let systemVerion:String = {
        return UIDevice.current.systemVersion
    }()
    
    static let idfa:String = {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }()
    
//    static let odid:String = {
//        return OpenUDID.value() ?? ""
//    }()
    
    // 是否是AppStore版本
    static let isAppStore:Bool = {
        return k_bundle_id == k_company_id
    }()
    
    static let alipaySchemes:String = {
        var t = "alipay.creat.order.ubake" // 默认appstore
        let infos = Bundle.main.infoDictionary ?? [String:Any]()
        let array = JSON(infos)["CFBundleURLTypes"].arrayValue
        for item in array {
            if "alipay" == item["CFBundleURLName"].stringValue{
                t = item["CFBundleURLSchemes"].arrayValue.first?.stringValue ?? ""
                break
            }
        }
        return t
    }()
}
