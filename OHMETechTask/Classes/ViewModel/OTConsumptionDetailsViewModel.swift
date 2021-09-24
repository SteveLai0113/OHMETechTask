//
//  OTConsumptionDetailsViewModel.swift
//  OHMETechTask
//
//  Created by Steve Lai on 24/9/2021.
//

import Foundation
import RxCocoa
import RxSwift

class OTConsumptionDetailsViewModel {
    
    public var record :BehaviorRelay<OTDailyConsumptionRecord>
    public var items = BehaviorRelay<[OTConsumptionItem]>(value: [])
    public var totalConsumption = BehaviorRelay<Int>(value: 0)
    private var disposeBag = DisposeBag()
    public init(record: OTDailyConsumptionRecord){
        self.record = BehaviorRelay<OTDailyConsumptionRecord>(value:record)
    }
    
    func setup() {
        self.record.subscribe(onNext:{[weak self] next in
            self?.items.accept(next.items ?? [])
        }).disposed(by: disposeBag)
        
        self.items.subscribe(onNext:{[weak self] next in
                        
            let sum = next.map({$0.consumptionWh}).reduce(0, +)
            self?.totalConsumption.accept(sum)
            
//            self?.itemsProportion.accept(next.map({Float($0.consumptionWh) / Float(sum)}))
        }).disposed(by: disposeBag)
        
    }
}
