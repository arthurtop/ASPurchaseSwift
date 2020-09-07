//
//  BussSmallTableCell.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/8/21.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit

class BussSmallTableCell: UITableViewCell {
    
    
    
    @IBOutlet weak var waitLabel: UILabel!
    
    @IBOutlet weak var tobeLabel: UILabel!
    
    @IBOutlet weak var deliveLabel: UILabel!
    
    @IBOutlet weak var cancelLabel: UILabel!
    
    func loadData(_ model: ASBussModel){
         
        waitLabel.text = String(model.data.sellerOrderStatistic.waitOrder)
        tobeLabel.text = String(model.data.sellerOrderStatistic.toBeDelivered)
        deliveLabel.text = String(model.data.sellerOrderStatistic.delivered)
        cancelLabel.text = String(model.data.sellerOrderStatistic.cancelled)

        
         
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
