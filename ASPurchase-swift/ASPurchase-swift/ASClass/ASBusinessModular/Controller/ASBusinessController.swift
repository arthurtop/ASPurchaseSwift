//
//  ASBusinessController.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/22.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

private let kGameViewH : CGFloat = 90

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

let kNormalItemW = (k_screen_width - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3

class ASBusinessController: ASBaseViewController, UIScrollViewDelegate {
    
    
    fileprivate lazy var busContentView: ASBusContentView = {[weak self] in
        let contFrame = CGRect(x: 0, y: 0, width: k_screen_width, height: k_screen_height-90)
        let contView = ASBusContentView(frame: contFrame)
        return contView
    }()
    
    fileprivate lazy var businessVM: ASBussViewModel = ASBussViewModel()
    
    
    fileprivate lazy var businessListView: BussCellListView = {
//        let view = BussCellListView.bussinessView()
        let contFrame = CGRect(x: 0, y: 0, width: k_screen_width, height: k_screen_height-88)
        
        let contView = BussCellListView(frame: contFrame)
        
        return contView
    }()
    
    /*
    fileprivate lazy var collectView : UICollectionView = {  [unowned self] in
       let layout = UICollectionViewFlowLayout()
       layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
       layout.minimumLineSpacing = 0
       layout.minimumInteritemSpacing = kItemMargin
       layout.headerReferenceSize = CGSize(width: k_screen_width, height: kHeaderViewH)
       layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()
    */
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavbar()
        
        setupUI()
        
    }
    
}

extension ASBusinessController {
    
    func loadBusinessData() {
        
        businessVM.requestBussinessData {
            
            self.businessListView.baseModel = self.businessVM.baseModel
            
            
        }
    }
    
    
}



extension ASBusinessController {
    
    func setupUI() {
        
//        view.addSubview(busContentView)
        
        
        view.addSubview(businessListView)
        loadBusinessData()
        
    }
    
    func settingNavbar() {
        title = "生意"
        
        
    }
    
    
}

