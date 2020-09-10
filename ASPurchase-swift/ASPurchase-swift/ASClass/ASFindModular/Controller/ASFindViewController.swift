//
//  ASFindViewController.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/22.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit

class ASFindViewController: ASBaseViewController {
    
    fileprivate lazy var fousVM: ASFindFousVM = ASFindFousVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadFindFousData()
        
        
    }
    

    

}


extension ASFindViewController {
    
    func loadFindFousData() {
        
        /*
        fousVM.findCommitList{
            
            
        }
        
        fousVM.findFousNotesData {
//            self.businessListView.baseModel = self.businessVM.baseModel
            
            
        }
         */
        
        
//        fousVM.attentionList {
//
//        }
        
        title = "发现"
        
        fousVM.attentionRecommend {
            
            print(self.fousVM.recommendModel)
            
            
            
        }
        
        
        
    }
    
    
}
