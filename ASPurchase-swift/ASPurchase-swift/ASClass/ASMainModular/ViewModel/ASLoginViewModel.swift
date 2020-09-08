//
//  ASLoginViewModel.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/8/10.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON


struct UserLogin:Encodable {
    
    let invitationCode:String
    let mobile: String
    let verificationCode:String
    let zipCode:String
    
}


class ASLoginViewModel: NSObject {
    
    static let manager = ASLoginViewModel()
    
//    let params: [String : Any] = ["invitationCode": "",
//                                  "mobile":"18682191134",
//                                  "verificationCode":"111222",
//                                  "zipCode": "+86"]
    
    let ASheaders: HTTPHeaders = ["Content-type" : "application/json;charset=utf-8",
    "Accept":"application/json"]
    
    
    func LoginStatus(finishCallback:@escaping () -> ()) {
        
        
        let parammms = UserLogin(invitationCode: "", mobile: "18611111111", verificationCode: "111222", zipCode: "+86")

        
        //// ------  使用 Alomfire 请求数据 HandyJSON 解析数据
//        AF.request("http://test.beautystudio.com.cn/dg/api/buyUser/V1.4.8/login",method: .post, parameters: parammms,encoder: JSONParameterEncoder.default,headers: ASheaders).responseJSON { (response) in
//            let data = JSON(response.value ?? "")["data"].dictionaryValue
//            DLog(data )
//            if let user = JSONDeserializer<UserModel>.deserializeFrom(dict: data){
//                DLog(user.userId)
//            }
//        }
        
        
        AS.POST(url: "/buyUser/V1.4.8/login", parameters: parammms, nil).success { (response) in
            let data = JSON(response)["data"].dictionaryValue
            if let user = JSONDeserializer<UserModel>.deserializeFrom(dict: data){
                DLog(user.userId)
                
                ASUserCenter.login(user)
                
                
                finishCallback()
            }
            
        }.failed { (error) in
            DLog(error)
        }
        
        
        
        
    }
    
    
    
    
    
}
