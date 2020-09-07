//
//  ASUserTokenModel.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/24.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit

class ASUserTokenModel: NSObject {
    
    
    /// 登录获取
    
    /// 用户名（keychain保存）
    public var userAccout:String = ""    //Keychian - accout
    
    /// 唯一身份码（keychain保存）
    public var accessToken:String = "user_token"    //Keychian -
    
    override init() {}
    
    
}


extension ASUserTokenModel {
    
    /// get
    ///
    /*
    public class func getLoginInfoModel() -> UserTokenModel? {
        do{
            if let model = try KeychianManage.fetchAllToken().first{
                let mm = UserTokenModel()
                mm.userAccout = model.key
                mm.accessToken = model.value
                return mm
            }else{return nil}
        }
        catch{return nil}
    }
    
    
    /// update
    ///
    public class func updateUserLoginInfoModel(_ userAccout:String, accessToken:String)->UserTokenModel?
    {
        //保证同时只有一个账号
        do {
            let _ = try KeychianQuery.fetchKeychainData(account: userAccout)
        } catch KeychainError.infoEmpty {
            do {
                try KeychianManage.deleteAllAccoutInfo()
            } catch {}
        } catch {}
        
        let model = UserTokenModel()
        model.accessToken = accessToken
        model.userAccout = userAccout
        do {
            try
                KeychianQuery.saveKeychainData(account: userAccout, accoutInfo: accessToken)
            return model
        } catch {
            print(accessToken)
            return nil
        }
    }
    
    
    /// clean
    ///
    public class func cleanUserLoginInfoModel() {
        do {
            try KeychianManage.deleteAllAccoutInfo()
        } catch {
            print(UserInfoShared.userLoginInfoModel.userAccout)
        }
    }
 */
}
