//
//  ASHomeViewController.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/22.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import Foundation




class ASHomeViewController: ASBaseViewController {
    
    
    fileprivate lazy var loginVM:ASLoginViewModel = ASLoginViewModel()
    
    fileprivate var homeVM: ASHomeViewModel = ASHomeViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        loginVM.LoginStatus{
            
            self.homeVM.homeRequestData { (model) in
                
                print(model.message!,model.data)
                
            }
            
        }
        
        

        
        
        
       
        
        
    }
    
    
    
    
}



extension String{
    
    func encodeToBase64() -> String {
        guard let data = self.data(using: String.Encoding.utf8) else {
            print("加密失败");
            return ""}
        return data.base64EncodedString(options: Data.Base64EncodingOptions.endLineWithLineFeed)
    }
    
    
    var base64 :String{
        get{

            let strData = self.data(using: .utf8)

            let data64 = strData?.base64EncodedData()

            let str64 = String(data: data64!, encoding: .utf8)

            return str64 ?? ""
        }
    }
}

/*
接口 = http://test.beautystudio.com.cn/dg/api/buyUser/V1.4.8/login
返回值 = {
    code = 0;
    data =     {
        accountBalance = "999881.77";
        activePrice = "0.01";
        activeType = 1;
        buyMobile = 18682191134;
        buyName = SooLe;
        buySignature = "";
        endDate = 2041084799000;
        forbid = "<null>";
        headerImage = "http://image.beautystudio.com.cn/dev.beautystudioo.com.cn/buyerbee/img/dg_1289482838089011200.jpeg";
        iMId = 19655;
        id = 19655;
        identity = "";
        imToken = "cBQuWSYtjf+UH4i/xR/djBl0FpFPethWu9I96nPW4Ys=@d6si.cn.rongnav.com;d6si.cn.rongcfg.com";
        isFirst = 0;
        isSetPayPassword = 1;
        levelId = 1;
        loginPassword = 0;
        mainImg = "http://image.beautystudio.com.cn/beautystudioo.com.cn/buyerbee/img/dg_default.png";
        remark = "\U7528\U6237\U6765\U6e90\U4e8eAPP\U767b\U5f55";
        shopImage = "";
        token = "fd35c168-7f10-46ff-b93d-918d8b935f43";
        userSex = 1;
        visitId = "<null>";
        zipCode = "+86";
    };
    message = success;
    timestamp = 1597047775437;
}
*/
