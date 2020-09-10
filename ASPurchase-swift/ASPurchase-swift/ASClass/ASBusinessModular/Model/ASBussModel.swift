//
//  ASBussModel.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/9/2.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import HandyJSON
import RxSwift





struct ASBussModel:HandyJSON, BaseResponse {
    
    var code: Int?
    
    var message: String?
    
    var timestamp: Float64?
    
    var data = ASBusData()
    
    struct ASBusData {
        
        var billStatistic = BillStatistic()
        
        var businessStatistic = BusinessStatistic()
        
        var sellerOrderStatistic = SellerOrderStatistic()
        
        
        struct BillStatistic  {
            var delivered: Int = 0
            var haveAfter: Int = 0
            var noPurchase: Int = 0
            var toBeDelivered: Int = 0
            
        }
        
        
        struct BusinessStatistic  {
            var todayAmount: String = "0.00";
            var todayOrderNum: Int = 0;
            var todayUserNum: Int = 0;
            var ytdAmount: String = "0.00";
            var ytdOrderNum: Int = 0;
            var ytdUserNum: Int = 0;
        }
        
        
        struct SellerOrderStatistic {
            var afterSale: Int = 0;
            var cancelled: Int = 0;
            var delivered: Int = 2;
            var toBeDelivered: Int = 0;
            var waitOrder: Int = 2;
            
        }
        
    }
}

extension ASBussModel {
    func fetchSkyData() -> Observable<ASBussModel> {
        return APIUtil.fetchData(with: .tianqi, method: .get, parameters: ["" : ""], returnType: ASBussModel.self).map({ (response: ASBussModel) -> ASBussModel in
            return response
        })
    }
}



/*
{
 "code":0,
  "data":{
    "billStatistic":{
         "delivered":0,
         "haveAfter":0,
         "noPurchase":0,
         "toBeDelivered":3
        },
    "businessStatistic":{
        "todayAmount":"0.00",
        "todayOrderNum":0,
        "todayUserNum":0,
        "ytdAmount":"0.00",
        "ytdOrderNum":0,
        "ytdUserNum":0
        },
    "sellerOrderStatistic":{
         "afterSale":0,
         "cancelled":0,
         "delivered":2,
         "toBeDelivered":0,
         "waitOrder":2
        }
    },
    "message":"success",
    "timestamp":1599120360870
 }
*/

/*"{\"code\":0,\"data\":{\"billStatistic\":{\"delivered\":0,\"haveAfter\":0,\"noPurchase\":0,\"toBeDelivered\":3},\"businessStatistic\":{\"todayAmount\":\"0.00\",\"todayOrderNum\":0,\"todayUserNum\":0,\"ytdAmount\":\"0.00\",\"ytdOrderNum\":0,\"ytdUserNum\":0},\"sellerOrderStatistic\":{\"afterSale\":0,\"cancelled\":0,\"delivered\":2,\"toBeDelivered\":0,\"waitOrder\":2}},\"message\":\"success\",\"timestamp\":1599457092869}"*/


/*{"code":0,"data":{"billStatistic":{"delivered":0,"haveAfter":0,"noPurchase":0,"toBeDelivered":3},"businessStatistic":{"todayAmount":"0.00","todayOrderNum":0,"todayUserNum":0,"ytdAmount":"0.00","ytdOrderNum":0,"ytdUserNum":0},"sellerOrderStatistic":{"afterSale":0,"cancelled":0,"delivered":2,"toBeDelivered":0,"waitOrder":2}},"message":"success","timestamp":1599457845488}
 
 ASBussModel(data: ASPurchase_swift.ASBussModel.ASBusData(billStatistic: ASPurchase_swift.ASBussModel.ASBusData.BillStatistic(delivered: 0, haveAfter: 0, noPurchase: 0, toBeDelivered: 0), businessStatistic: ASPurchase_swift.ASBussModel.ASBusData.BusinessStatistic(todayAmount: "0.00", todayOrderNum: 0, todayUserNum: 0, ytdAmount: "0.00", ytdOrderNum: 0, ytdUserNum: 0), sellerOrderStatistic: ASPurchase_swift.ASBussModel.ASBusData.SellerOrderStatistic(afterSale: 0, cancelled: 0, delivered: 2, toBeDelivered: 0, waitOrder: 2)), code: Optional(0), message: Optional("success"), timestamp: Optional(1599457845488.0))*/




