//
//  OTConsumptionRecordDetailsViewController.swift
//  OHMETechTask
//
//  Created by Steve Lai on 24/9/2021.
//

import UIKit
import RxCocoa
import RxSwift

class OTConsumptionRecordDetailsViewController: UIViewController {

    @IBOutlet weak var chart: OTConsumptionChart!
    @IBOutlet weak var lbConsumptionTitle: UILabel!
    @IBOutlet weak var tvConsumptionItems: UITableView!
    public var dailyRecord: OTDailyConsumptionRecord?
    public var viewModel: OTConsumptionDetailsViewModel?
    private var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 0. UI
        self.tvConsumptionItems.register(UINib.init(nibName: "OTConsumptionItemTableViewCell", bundle: nil), forCellReuseIdentifier: OTConsumptionItemTableViewCell.cellId)
        // 1.
        self.viewModel = OTConsumptionDetailsViewModel(record: dailyRecord!)
        self.viewModel?.setup()
        
        self.viewModel?.record.subscribe(onNext:{[weak self] next in
            self?.chart.dailyRecord = next
        }).disposed(by: disposeBag)
        
       
        self.viewModel?.items.bind(to: self.tvConsumptionItems
                                        .rx
                                        .items(cellIdentifier: OTConsumptionItemTableViewCell.cellId, cellType: OTConsumptionItemTableViewCell.self)){row, data, cell in
            cell.lbTitle.text = data.name
            cell.lbConsumption.text = String(format: "%.2fkWh", Float(data.consumptionWh) / 1000)
            cell.vBar.backgroundColor = OTConsumptionChart.colors[row % OTConsumptionChart.colors.count]
            let proportion = self.viewModel?.record.value.consumptionProportion(withId: data.id)
            cell.vBar.applyTransform(withScale: CGPoint(x: CGFloat(proportion ?? 0), y: 1), anchorPoint: CGPoint(x: 0, y: 0.5))
            
        }.disposed(by: disposeBag)
        
        
        self.viewModel?.totalConsumption.asObservable().map({value in
            return "\(Float(value) / 1000)kWh"
        }).bind(to: self.lbConsumptionTitle.rx.text).disposed(by: disposeBag)
       
    }


}

