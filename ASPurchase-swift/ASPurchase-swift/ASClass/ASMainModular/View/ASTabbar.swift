//
//  ASTabbar.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/22.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import Foundation
import RxSwift




class ASTabbar: UITabBar {
    
    
    //
    var callBack:(() -> Void)?
    let dispose = DisposeBag()
    
    
    /***  按钮   ***/
    public lazy var centerBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentMode = UIView.ContentMode.center
        btn.backgroundColor = UIColor(r: 250.0, g: 250.0, b: 250.0)
        btn.layer.cornerRadius = 30
        btn.layer.masksToBounds = true
        btn.adjustsImageWhenHighlighted = false
        
        btn.contentEdgeInsets = UIEdgeInsets(top: -3, left: 0, bottom: 3, right: 0)
        
        
        btn.setImage(UIImage(named: "icon_tabbar_store"), for: .selected)
        btn.setImage(UIImage(named: "icon_tabbar_store_normal"), for: .normal)
        
        
//        btn.addTarget(self, action: #selector(shopMinddelBtn), for: UIControl.Event.touchUpInside)
        
        
        // RxSwift
        btn.rx.tap.subscribe(onNext: { () in
            
            btn.isHighlighted = false
            
            self.callBack!()
        }).disposed(by: dispose)
        
//        btn.rx.title().onNext("我的啊你怎么")
        
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(centerBtn)
        
        
    }
    
    
    @objc func shopMinddelBtn(sender: UIButton) {
//        DLog("shopMinddelBtn 中间点击事件")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        self.centerBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        
        if iOS.isIphoneXLater {
            centerBtn.center = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.25-5)
        }else{
            centerBtn.center = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.4-5)
        }
        
    }
    
    
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if self.isHidden == false {
            
            let newPoint:CGPoint = convert(point, to: centerBtn)
            
            if centerBtn.point(inside: newPoint, with: event) {
                return centerBtn
            }else{
                return super.hitTest(point, with: event)
            }
        }else {
            return super.hitTest(point, with: event)
        }
    }
    
    
    
    
    
    
    
    //让图片和文字在iOS11下仍然保持上下排列
//    override open var traitCollection: UITraitCollection {
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            return UITraitCollection(horizontalSizeClass: .compact)
//        }
//        return super.traitCollection
//    }

}
