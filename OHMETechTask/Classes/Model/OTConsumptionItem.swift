//
//  OTSpendingCategory.swift
//  OHMETechTask
//
//  Created by Steve Lai on 23/9/2021.
//

import Foundation
import HandyJSON

public class OTConsumptionItem: HandyJSON{
    
    var id: String!
    var name: String!
    var consumptionWh: Int = 0
    
    public required init(){}
}
