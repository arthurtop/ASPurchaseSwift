//
//  BussOrderTableCell.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/8/21.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit

class BussOrderTableCell: UITableViewCell {

    
    @IBOutlet weak var noBuyLabel: UILabel!
    
    
    
    @IBOutlet weak var tobeLabel: UILabel!
    
    
    @IBOutlet weak var deliverLabel: UILabel!
    
    
    @IBOutlet weak var afterLabel: UILabel!
    
    
    func loadData(_ model: ASBussModel){
         
        noBuyLabel.text = String(model.data.billStatistic.noPurchase)
        tobeLabel.text = String(model.data.billStatistic.toBeDelivered)
        deliverLabel.text = String(model.data.billStatistic.delivered)
        afterLabel.text = String(model.data.billStatistic.haveAfter)

         
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
