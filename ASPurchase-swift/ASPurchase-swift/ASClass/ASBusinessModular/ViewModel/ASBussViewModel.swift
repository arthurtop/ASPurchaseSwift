//
//  ASBussViewModel.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/23.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
import Alamofire
import RxSwift



class ASBussViewModel{
    
    let disposeBag = DisposeBag()
    
    
    lazy var baseModel: ASBussModel = ASBussModel()
    
    // 生意界面数据请求
    func requestBussinessData(finishedCallback : @escaping () -> ()) {

        ASAFNetwork<ASBussModel>.requestDatas(.get, urlString: "saleStatistic/home") { (response) in
            
//            self.baseModel = JSONDeserializer<ASBussModel>.deserializeFrom(json: response)!
//            print(response,self.baseModel)
            
            print(response)
            
            finishedCallback()
            
        }
    }
    
    
    
    
    
    func requestData() {
        
//        XLZNetworking<WenJson>().method(.GET).configRequest { (request) in
//           // 设置 request
//        }.requestJSON("") { (data) in
//           // data
//        }
        
        
//        XLZNetworking<BussinessJson>().requestJSON("http://test.beautystudio.com.cn/dg/api/saleStatistic/home") { (jsonModel) in
//
//            print(jsonModel)
//
//        }
        
        
//        XLZNetworking<BussinessJson>().requestJSON("http://test.beautystudio.com.cn/dg/api/saleStatistic/home") { (response) in
//            print(response)
//
////            self.bussinModel = JSONDeserializer<ASBusHomeModel>.deserializeFrom(dict: response)!
//
//            self.baseModel = response as! ASBussModel
//
//        }
        
    }
    
    
    
    func rxNetworkData() {
        
        /*
        self.baseModel.fetchSkyData().subscribe(onNext: { [weak self] model in
//            self?.cityNameLb.text = model.skinfo!.cityName!
//            print(APIUtil.httpsHeaders, model)
            
        }, onError: { (error) in
            print(error)
            print(APIUtil.httpsHeaders)
        }).disposed(by: disposeBag)
        */
    }
    
    
}



