//
//  OTConsumptionListViewModel.swift
//  OHMETechTask
//
//  Created by Steve Lai on 23/9/2021.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources


public class OTConsumptionListViewModel{
    public var monthlyConsumptions = BehaviorRelay<[OTMonthlyConsumptionRecord]>(value: [])
    public var monthConsumption = BehaviorRelay<[OTDailyConsumptionRecord]>(value:[])
    
    private var disposeBag = DisposeBag()
    private var api = OTMockingApiManager()
    
    
    
    
    
    public func setup(){
        api.requestGETMonthlyConsumptionRecords().subscribe(onNext:{[weak self] (response) in
            self?.monthlyConsumptions.accept(response.data ?? [])
            self?.monthConsumption.accept(response.data?.first?.dailyRecords ?? [])
        }).disposed(by: disposeBag)
        
    }
    
    
}



