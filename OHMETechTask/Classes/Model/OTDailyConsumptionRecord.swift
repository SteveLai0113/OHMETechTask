//
//  OTDailySpendingRecord.swift
//  OHMETechTask
//
//  Created by Steve Lai on 23/9/2021.
//

import Foundation
import HandyJSON


public class OTDailyConsumptionRecord: HandyJSON{
    var date: Date!
    var items: [OTConsumptionItem]?
    public required init() {}
    
    public func mapping(mapper: HelpingMapper) {
        mapper <<< date <-- CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    }
    
    /// Returning the proportion fo the items in the date
    public func consumptionProportion(withId id:String) -> Float{
        guard let index = items?.firstIndex(where: {$0.id == id}) else {
            return 0
        }
        
        guard let total = totalConsumption() else {
            return 0
        }
        let item = items![index]
        
        return Float(item.consumptionWh) / Float(total)

    }
    
    public func totalConsumption() -> Int?{
        return items?.map({$0.consumptionWh}).reduce(0, +)
    }
}
