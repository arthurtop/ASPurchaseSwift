//
//  ASUserInfo.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/24.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit

let UserInfoShared = ASUserInfo.shared

final class ASUserInfo: NSObject {
    
    public static let shared = ASUserInfo()
    
    /// 是否已登录且已验证生物识别
    public class func isLogged() -> Bool{return shared._isLogged()}
    
    /// 登录用户个人信息
    private(set) var userLoginInfoModel : ASUserTokenModel = ASUserTokenModel()
    
    /// 登录用户职位信息
    private(set) var userInfoModel:ASUserInfoModel = ASUserInfoModel()
    
    override init() {
        super.init()
        
//        if let loginModel = ASUserTokenModel.getLoginInfoModel() {
//            self.userLoginInfoModel = loginModel
//        }
//        if let infoModel = ASUserInfoModel.getInfoModel()  {
//            self.userInfoModel = infoModel
//        }
        
    }
    
    
}


// MARK: - 登录信息
extension ASUserInfo {
    
    public class func setUserInfoModel(_ userAccout:String, accessToken:String) {
        
        
        
    }
    
    
    private func _isLogged() -> Bool {
        if userLoginInfoModel.accessToken.count > 0 &&
        userLoginInfoModel.userAccout.count > 0{
            return true
        }
        return false
    }
    
}

//MARK: - 个人信息
extension ASUserInfo {

    /// 更新本地个人信息
    ///
    public class func setUserVirtualModel(_ userInfo:ASUserInfoModel)
    {
        shared.userInfoModel = userInfo
        ASUserInfoModel.updateUserInfoModel(userInfo)
    }
}


// MARK: - 退出登录
extension ASUserInfo {

    ///  清空本地用户数据
    ///
    public class func logouWithCleanLocation(){
//        ASUserTokenModel.cleanUserLoginInfoModel()
        ASUserInfoModel.cleanUserInfoModel()
    }
}
