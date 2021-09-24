//
//  OTConsumptionItemTableViewCell.swift
//  OHMETechTask
//
//  Created by Steve Lai on 24/9/2021.
//

import UIKit

class OTConsumptionItemTableViewCell: UITableViewCell {

    public static let cellId = "id_consumption_item_cell"
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbConsumption: UILabel!
    @IBOutlet weak var vBar: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
