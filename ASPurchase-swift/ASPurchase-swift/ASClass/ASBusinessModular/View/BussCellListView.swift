//
//  BussCellListView.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/8/20.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources



private let kEdgeInsetMargin : CGFloat = 10

private let kItemMargin:CGFloat = 10.0

class BussCellListView: UIView, UIScrollViewDelegate {
    
    let datas = BussinessDatas()
    
    let shopCellID = "shopCellID"
    let smallCellID = "smallCellID"
    let orderCellID = "orderCellID"
    let toolCellID = "toolCellID"
    
    
    let disposeBag = DisposeBag()
    
    
    
    
    
//    @IBOutlet weak var collectView: UICollectionView!
    
    
//    fileprivate lazy var collectView : UICollectionView = {  [unowned self] in
//
//        let layout = UICollectionViewFlowLayout()
//       layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
//       layout.minimumLineSpacing = 0
//       layout.minimumInteritemSpacing = kItemMargin
//       layout.headerReferenceSize = CGSize(width: k_screen_width, height: 50)
//       layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
//
//        // 2.创建UICollectionView
////        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
//
//        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: k_screen_width, height: k_screen_height), collectionViewLayout: layout)
//
//        collectionView.backgroundColor = UIColor.white
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//
//
//        return collectionView
//    }()
    
    fileprivate lazy var myTableView: UITableView = {[weak self] in
//        let frame = CGRect(x: 0, y: 0, width: k_screen_width, height: k_screen_height-90)
        let tableview = UITableView(frame: CGRect.zero, style: .plain)
        tableview.backgroundColor = .clear
        
        tableview.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        tableview.register(UINib(nibName: "BussShopTableCell", bundle: nil), forCellReuseIdentifier: shopCellID)
        tableview.register(UINib(nibName: "BussSmallTableCell", bundle: nil), forCellReuseIdentifier: smallCellID)
        tableview.register(UINib(nibName: "BussOrderTableCell", bundle: nil), forCellReuseIdentifier: orderCellID)
        tableview.register(UINib(nibName: "BussToolTableCell", bundle: nil), forCellReuseIdentifier: toolCellID)
        
       return tableview
    }()
    
    
    var baseModel : ASBussModel? {
        didSet {
                   // 刷新表格
            myTableView.reloadData()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

extension BussCellListView {
    
    func setupTableView() {
            
        addSubview(myTableView)
        myTableView.frame = bounds
        
        
       let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ASBussModel>>(configureCell: {[weak self] (dataSource, tableView, indexPath, model) -> UITableViewCell in
    
            
            if indexPath.section == 0 {
                let cell:BussShopTableCell = tableView.dequeueReusableCell(withIdentifier: self!.shopCellID, for: indexPath) as! BussShopTableCell
                tableView.rowHeight = 200.0
                
                cell.loadData(model)
                
                
                return cell
            }else if indexPath.section == 1 {
                let cell:BussSmallTableCell = tableView.dequeueReusableCell(withIdentifier: self!.smallCellID, for: indexPath) as! BussSmallTableCell

                tableView.rowHeight = 120.0
                
                 cell.loadData(model)
                
                return cell
            }else if indexPath.section == 2 {
                
                let cell:BussOrderTableCell = tableView.dequeueReusableCell(withIdentifier: self!.orderCellID, for: indexPath) as! BussOrderTableCell
                
                tableView.rowHeight = 133.0
                
                 cell.loadData(model)
                
                return cell
            } else{
                let cell:BussToolTableCell = tableView.dequeueReusableCell(withIdentifier: self!.toolCellID, for: indexPath) as! BussToolTableCell
                
                tableView.rowHeight = 133.0
                
                return cell
            }
            
        }
            , titleForHeaderInSection: { ds, index in
                
            return ""//ds.sectionModels[index].model
        })
        
        
        
        
        // 数据加载
 
        datas.asyBusinsessData.asDriver(onErrorJustReturn: [])
            .drive(myTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // cell 点击
        myTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                print("选中项indexpath:\(indexPath)")
            }).disposed(by: disposeBag)
        
        myTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
    }
    
    
    
    class BussinessDatas {
        
        let asyBusinsessData = Observable.just(
            [
                SectionModel(model: "", items: [ASBussModel()]),
                SectionModel(model: "", items: [ASBussModel()]),
                SectionModel(model: "", items: [ASBussModel()]),
                SectionModel(model: "", items: [ASBussModel()])
            ]
        )
        
    }
    
    
    
    
}

extension BussCellListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
    
    override func addSubview(_ view: UIView) {
        if !view.isKind(of: (NSClassFromString("_UITableViewCellSeparatorView")!)) {
            super.addSubview(view)
        }
    }
    
}




extension BussCellListView {
    class func bussinessView() -> BussCellListView {
        return Bundle.main.loadNibNamed("BussCellListView", owner: nil, options: nil)?.first as! BussCellListView
    }
}

/*
extension BussCellListView : UICollectionViewDataSource ,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! BussLabelCell
//        let model = ASBusHomeModel()
//        cell.baseData = model
        
        cell.numLabel.text = "1241241241"
        cell.titleLabel.text = "今日订单数"
        
        
        return cell
    }
    
    
}
*/

