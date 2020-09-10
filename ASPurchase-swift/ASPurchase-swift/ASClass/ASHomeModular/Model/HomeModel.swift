//
//  HomeModel.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/9/8.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import HandyJSON



struct HomeModel: HandyJSON, BaseResponse {
    
    var code: Int?
    
    var message: String?
    
    var timestamp: Float64?
    
    
    var data = [DataModel]()
    
    
    struct DataModel: HandyJSON {
        
        var backgroundImg: String?
        
        var bannerList: [String]?
        
        var broadcast = Broadcast()
        
        struct Broadcast: HandyJSON {
            
            var contentList: [String]?
            
            var fontColor: String?
            var id: String?
            var linkUrl: String?
            
        }
        
        var componentTemplateId: String?
        
        var componentTypeCode: String?
        
        var id: String?
        
        var thematicVO = ThematicVO()
        
        struct ThematicVO: HandyJSON {
            
            var bannerId: String?
            var bannerImg: String?
            
            var jumpTypeCode: String?
            
            var listName: String?
            
            var recommendProductList = [RecommendProductList]()
            
            struct RecommendProductList: HandyJSON {
                
                var goodsSourceId: String?
                var mainImg: String?
                var providerId: String?
                var title: String?
                var wholesalePrice: Float32 = 0.0
                
            }
            
        }
        
        var topDistance: Int?
        
        
    }
    
    
    
    
    
}
