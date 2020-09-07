//
//  ASMineViewController.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/22.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit

class ASMineViewController: ASBaseViewController {
    
    fileprivate lazy var headerView: ASMineHeaderView = {
        let view = ASMineHeaderView.mineHeaderView()
        view.frame = CGRect(x: 0, y: 0, width: k_screen_width, height: 300)
        
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingUI()
        
        
        
    }
    
}


/***  setting UI    ***/
extension ASMineViewController {
    
    func settingUI() {
        
        setupNavigationBar()
        
        view.addSubview(headerView)
        
    }
    
    
    
    
    
    
    func setupNavigationBar() {
        
        // 1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        
        let messageItem = UIBarButtonItem(imageName: "imCount_img", highImageName: "imCount_img", size: size)
        let settingItem = UIBarButtonItem(imageName: "icon_userWhite_img", highImageName: "icon_userWhite_img", size: size)
        
        navigationItem.rightBarButtonItems = [settingItem,messageItem]
        
        self.navigationController?.navigationBar.barTintColor = k_333333
        
        title = "个人中心"
        
    }
    
    
}

