//
//  ASUserInfoModel.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/24.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit


let REGISTER_TOKEN_LOCAL_FILENAME = "REGISTER_TOKEN_LOCAL_FILENAME"

class ASUserInfoModel: NSObject, NSCoding {
    
    
    /// 名称
    public var name:String = "name"
    
    /// 电话
    public var phone:String = ""
    
    /// 头像
    public var userPhoto:String = ""
    
    override init() {}
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.phone, forKey: "phone")
        aCoder.encode(self.userPhoto, forKey: "userPhoto")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.phone = aDecoder.decodeObject(forKey: "phone") as! String
        self.userPhoto = aDecoder.decodeObject(forKey: "userPhoto") as! String
    }
    
    
    
    
}

extension ASUserInfoModel {
    
    /// get
    ///
    public class func getInfoModel() -> ASUserInfoModel? {
        if let infoModel = ASLocationCacheManage.DDUnarchive(fileName: REGISTER_TOKEN_LOCAL_FILENAME) as? ASUserInfoModel {
            return infoModel
        }else{
            return nil
        }
    }
    
    /// update
    ///
    public class func updateUserInfoModel(_ userInfo:ASUserInfoModel){
        if ASLocationCacheManage.DDArchive(fileName: REGISTER_TOKEN_LOCAL_FILENAME, objc: userInfo) {
        }else{
            print("失败")
        }
    }
    
    /// clean
    ///
    public class func cleanUserInfoModel() {
        ASLocationCacheManage.DDFileDelete(fileName: REGISTER_TOKEN_LOCAL_FILENAME)
    }
}


