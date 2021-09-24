//
//  OTConsumptionResponse.swift
//  OHMETechTask
//
//  Created by Steve Lai on 23/9/2021.
//

import Foundation
import HandyJSON

public class OTConsumptionResponse: HandyJSON{
    var data: [OTMonthlyConsumptionRecord]?
    public required init(){}
}
