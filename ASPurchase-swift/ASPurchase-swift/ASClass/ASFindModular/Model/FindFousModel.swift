

//
//  FindFousModel.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/9/7.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import HandyJSON
//import BaseDataModel


struct FindFousModel: HandyJSON, BaseDataModel {
    
    var code: Int?
    
    var message: String?
    
    var timestamp: Float64?
    
    
    
    
    
    

}

/** 数据请求接口模型
    attention/list
    attention/recommend
 **/


struct AttentionList: HandyJSON, BaseDataModel {
    
    var code: Int?
    
    var message: String?
    
    var timestamp: Float64?
    
    var data = DataModel()
    
    
    struct DataModel: HandyJSON{
        
        var endRow: Int = 0
        var firstPage: Int = 0
        var hasNextPage: Bool?
        var hasPreviousPage: Bool?
        var isFirtPage: Bool?
        var isLastPage: Bool?
        var lastPage: Int = 0
        
        var navigatepageNums: [Int]?
        
        var nextPage: Int?
        var pageNum: Int?
        var pageSize: Int?
        var pages: Int?
        var prePage: Int?
        var size: Int?
        var startRow: Int?
        var total: Int?
        
        var list = [ListModel]()
        
        
        
        struct ListModel: HandyJSON {
            init() {
            }
            
            var headerImg: String?
            var imId: String?
            var shopName: String?
            var type: Int?
            
            // ----recommend 接口
            var id: String?
            var recommendProductList = [ProductList]()
            
            struct ProductList: HandyJSON {
                var goodsName: String?
                var id: String?
                var image: String?
                var speedDelivery: Int?
                
            }
            
             // ----list 接口
            var gid: String?
            var goodsName: String?
            
//            var imId: String?
            var mainUrl: String?
            
            var images: [Images]?
            struct Images: HandyJSON {
                var id: String?
                var url: String?
            }
            
            var pid: String?
            var price: Double = 0.0
            
            
            var skuVoList: [SkuVoLists]?
            
            struct SkuVoLists: HandyJSON {
                
                var biyouWholesalePrice: Double = 0.0
                var currencyType: String?
                var marketPrice: Double = 0.0
                
                var properties: [String]?
                
                var propertiesGroup: String?
                
                var retailPriceRmb: Double = 0.0
                var rmbMarketPrice: Double = 0.0
                var skuId: String?
                var wholesalePrice: Double = 0.0
                
                
            }
            
            var speedDelivery: Int = 0
            var time: Float64?
            
            var updateDateString: String?
            
        }
        
    }
    
}

