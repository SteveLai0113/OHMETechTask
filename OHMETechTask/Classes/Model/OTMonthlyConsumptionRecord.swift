//
//  OTMonthlySpendingRecord.swift
//  OHMETechTask
//
//  Created by Steve Lai on 23/9/2021.
//

import Foundation
import HandyJSON

public class OTMonthlyConsumptionRecord: HandyJSON{
    public var dailyRecords: [OTDailyConsumptionRecord]?
    public required init() {
    }
}
