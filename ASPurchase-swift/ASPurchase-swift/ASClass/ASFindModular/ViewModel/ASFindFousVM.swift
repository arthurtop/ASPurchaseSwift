//
//  ASFindFousVM.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/9/7.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import HandyJSON


class ASFindFousVM {
    
//    notes/class
//    notes/activity/type
//    attention/list
//    attention/recommend
    
    lazy var listModel: AttentionList = AttentionList()
    lazy var recommendModel: AttentionList = AttentionList()
    
    func findFousNotesData(finishCallback: @escaping () -> ()) {
        
        let parameters = ["type":"15"]
        
        ASAFNetwork<AttentionList>.requestDatas(.get, urlString: "notes/activity/banner", parameters: parameters) { (response)in
            
            print(response)
            
            finishCallback()
        }
        
    }
    
    
    func findCommitList(finishCallback: @escaping () -> ()) {
        
        ASAFNetwork<AttentionList>.requestDatas(.get, urlString: "notes/class") { (response) in
            
            print(response)
            
            finishCallback()
        }
        
    }
    
    
    /***  关注 列表   ***/
    func attentionList(callback:@escaping () -> ()) {
        let parameters = ["pageNum":"1","pageSize":"10"]
        ASAFNetwork<AttentionList>.requestDatas(.get, urlString: "attention/list",parameters: parameters) { (response) in
            
//            print(response)
//            self.listModel = JSONDeserializer<AttentionList>.deserializeFrom(json: response)!
            
            callback()
        }
        
    }
    
    /***  关注默认推荐 列表   ***/
    func attentionRecommend(callback:@escaping () -> ()) {
        
        let parameters = ["pageNum":"1","pageSize":"10"]
        ASAFNetwork<AttentionList>.requestDatas(.get, urlString: "attention/recommend",parameters: parameters) { (response) in
            
            print(response)
            
//            self.recommendModel = JSONDeserializer<AttentionList>.deserializeFrom(json: response)!
            
            callback()
        }
        
    }
    
    
    
}
