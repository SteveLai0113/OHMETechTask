//
//  OTMonthlySpendingTableViewCell.swift
//  OHMETechTask
//
//  Created by Steve Lai on 23/9/2021.
//

import UIKit

class OTMonthlyConsumptionTableViewCell: UITableViewCell {

    public static let cellId = "id_monthly_consumption_cell"
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbCaption: UILabel!
    @IBOutlet weak var lbConsumption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
