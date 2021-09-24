//
//  OTApiManager.swift
//  OHMETechTask
//
//  Created by Steve Lai on 23/9/2021.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import RxCocoa


public protocol OTApi{
    func requestGETMonthlyConsumptionRecords()-> Observable<OTConsumptionResponse>
}


public class OTMockingApiManager: OTApi{

    public static let shared = OTMockingApiManager()
    public func requestGETMonthlyConsumptionRecords()-> Observable<OTConsumptionResponse> {
        return MockUtils.rxLoadModel(fileName: "testdata_monthly_records", fileExt: "json", type: OTConsumptionResponse.self)
    }

}

public class OTApiService{
    let shared : OTApi
    
    init(manager: OTApi = OTMockingApiManager.shared) {
        self.shared = manager
    }
}
