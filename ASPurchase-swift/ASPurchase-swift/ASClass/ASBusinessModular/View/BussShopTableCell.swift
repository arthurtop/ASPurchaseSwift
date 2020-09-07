//
//  BussShopTableCell.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/8/21.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit

class BussShopTableCell: UITableViewCell {
    
    
    @IBOutlet weak var todayOrderLabel: UILabel!
    
    @IBOutlet weak var todayFinishLabel: UILabel!
    
    @IBOutlet weak var todayUserLabel: UILabel!
    
    
    
    
    @IBOutlet weak var yesterdayOrderLabel: UILabel!
    
    @IBOutlet weak var yesterdayFinishLabel: UILabel!
    
    @IBOutlet weak var yesterdayUserLabel: UILabel!
    
    
    
    func loadData(_ model: ASBussModel){
        
        todayOrderLabel.text = String(model.data.businessStatistic.todayOrderNum)
        todayFinishLabel.text = String(model.data.businessStatistic.todayAmount)
        todayUserLabel.text = String(model.data.businessStatistic.todayUserNum)
        
        
        yesterdayOrderLabel.text = String(model.data.businessStatistic.ytdOrderNum)
        yesterdayFinishLabel.text = String(model.data.businessStatistic.ytdAmount)
        yesterdayUserLabel.text = String(model.data.businessStatistic.ytdUserNum)
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
