//
//  ASUserCenter.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/23.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
//import ASDataTools
import RxSwift


enum ASLoginType:Int {
    case unkonwn = 0
    case visitor = 1  // 游客
    case wechat = 2   //微信登录
    case phone = 3   //手机验证码登录
    case password = 4 //密码登录
   
}


class ASUserCenter: NSObject {
    
    static let shared = ASUserCenter()
    
    
    
    var user:UserModel?
    
    
    private override init() {
        super.init()
        
//        user = ASDataTools.getObject()
        user = ASDataTools.getObject(forKey: "allSale.user") as? UserModel
        
        DLog("用户中心单例初始化成功！")
        
        
    }
    
    // 登录
    static func login(_ user:UserModel?) {
        
//        let disposeBag = DisposeBag()
        
        let center = ASUserCenter.shared
        center.user = user
        center.user?.loginType = .phone
        
        User = center.user ?? UserModel()
        ASDataTools.saveObject(User, forKey: "allSale.user")
        
        /// 发送通知 用户数据更新 通知刷新
//        let name = NSNotification.Name(rawValue: "refresh.home.notif")
//        NotificationCenter.default.post(name: name, object: nil)
        
        
//        NotificationCenter.default.rx.notification(Notification.Name(rawValue: "refresh.home.notif"))
//            .subscribe(onNext: { (notification) in
//                DLog(notification)
//            }).disposed(by: disposeBag)
        
    }
    
    // 退出登录
    static func logout() {
        let disposeBag = DisposeBag()
        
        let center = ASUserCenter.shared
        center.user = nil
        User = UserModel()
        ASDataTools.removeObject("allSale.user")
        
        // 发送通知
//        let name = NSNotification.Name(rawValue: "refresh.home.notif")
//        NotificationCenter.default.post(name: name, object: nil)
        
        NotificationCenter.default.rx.notification(Notification.Name(rawValue: "refresh.home.notif"))
        .subscribe(onNext: { (notification) in
            DLog(notification)
        }).disposed(by: disposeBag)
        
    }
    
    static func autoLogin() {
        User = ASUserCenter.shared.user ?? UserModel()
        if (User.isLogin) {
            DLog("用户已登录！")
        } else {
            DLog("用户未登录！")
        }
    }
    
    
}


class UserModel: NSObject ,NSCoding , HandyJSON{
    
    
    var loginType:ASLoginType = .unkonwn
    
    var isLogin:Bool {
        get {
            return !userId.isEmpty
        }
    }
    
    //用户id
   var  userId = ""

    //代购手机号
    var buyMobile = ""

    //城市代码
   var zipCode = ""

    //店铺icon
    var mainImg = ""

    //用户头像
    var headerImg = ""

    //代购人名字
    var buyName = ""

    //代购人签名
    var buySignature = ""

    //token
    var token:String = ""

    //用户性别
    var  userSex = ""

    //等级级别,大于0 就是代购用户,否则是非代购用户
    var  levelId = ""


    var levelUrl = ""/**< 注释 */

    //是否是第一次注册,用于登录那块的逻辑处理
    var  isFirst = ""

    //是否关注
    var  isFocus = ""

    //是否关注店铺
    var  shopFocus = ""

    //是否设置交易密码
    var  isSetPayPassword = ""

    //是否设置登录密码
   var  loginPassword = ""

    //账户余额
    var  accountBalance = ""

    //iMId
    var iMId = ""

    //粉丝数
    var fansNum = ""

    //关注数
    var focusNum = ""

    //代理数
   var  agentNum = ""

    //帖子数
    var  notesSum = ""

    //月单量
    var  monthNum = ""

    //s收藏数量
    var  collectionNum = ""

    var totalValue = ""

    var gmv = ""
    var gmvSum = ""
    var shopName = ""/**< 注释 */

    var photo = ""
    

    
    
    func encode(with coder: NSCoder) {
        
        coder.encode(self.userId, forKey: "id")
        coder.encode(buyMobile, forKey: "buyMobile")
        coder.encode(zipCode, forKey: "zipCode")
        coder.encode(mainImg, forKey: "mainImg")
        coder.encode(headerImg, forKey: "headerImg")
        coder.encode(buyName, forKey: "buyName")
        
        
        coder.encode(self.userId, forKey: "buySignature")
        coder.encode(buyMobile, forKey: "token")
        coder.encode(zipCode, forKey: "userSex")
        coder.encode(mainImg, forKey: "levelId")
        coder.encode(headerImg, forKey: "levelUrl")
        coder.encode(buyName, forKey: "isFirst")
        coder.encode(self.userId, forKey: "isFocus")
        coder.encode(buyMobile, forKey: "shopFocus")
        coder.encode(zipCode, forKey: "isSetPayPassword")
        coder.encode(mainImg, forKey: "loginPassword")
        coder.encode(headerImg, forKey: "accountBalance")
        coder.encode(buyName, forKey: "iMId")
        coder.encode(self.userId, forKey: "fansNum")
        coder.encode(buyMobile, forKey: "focusNum")
        coder.encode(zipCode, forKey: "agentNum")
        coder.encode(mainImg, forKey: "notesSum")
        coder.encode(headerImg, forKey: "monthNum")
        coder.encode(buyName, forKey: "collectionNum")
        coder.encode(buyMobile, forKey: "totalValue")
        coder.encode(zipCode, forKey: "gmv")
        coder.encode(mainImg, forKey: "gmvSum")
        coder.encode(headerImg, forKey: "shopName")
        coder.encode(buyName, forKey: "photo")
        
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init()
        
        userId = coder.decodeString("id")
        buyMobile = coder.decodeString("buyMobile")
        zipCode = coder.decodeString("zipCode")
        mainImg = coder.decodeString("mainImg")
        headerImg = coder.decodeString("headerImg")
        buyName = coder.decodeString("buyName")
        
        
        buySignature = coder.decodeString("buySignature")
       token  = coder.decodeString("token")
      userSex   = coder.decodeString("userSex")
       levelId  = coder.decodeString( "levelId")
       levelUrl  = coder.decodeString( "levelUrl")
       isFirst =  coder.decodeString( "isFirst")
        isFocus = coder.decodeString( "isFocus")
       shopFocus  = coder.decodeString( "shopFocus")
        isSetPayPassword = coder.decodeString( "isSetPayPassword")
       loginPassword  = coder.decodeString("loginPassword")
      accountBalance   = coder.decodeString( "accountBalance")
      iMId   = coder.decodeString("iMId")
      fansNum   = coder.decodeString("fansNum")
       focusNum  = coder.decodeString("focusNum")
       agentNum  = coder.decodeString( "agentNum")
       notesSum  = coder.decodeString( "notesSum")
       monthNum  = coder.decodeString( "monthNum")
       collectionNum  = coder.decodeString( "collectionNum")
      totalValue   = coder.decodeString( "totalValue")
      gmv   = coder.decodeString( "gmv")
       gmvSum =  coder.decodeString( "gmvSum")
      shopName   = coder.decodeString( "shopName")
       photo =  coder.decodeString( "photo")
        
        
        
        
        
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
        userId <-- "id"
    }
    
    
    required override init() {
        super.init()
    }
    
    
    
    
}










