//
//  OTSpendingRecordsViewController.swift
//  OHMETechTask
//
//  Created by Steve Lai on 23/9/2021.
//

import UIKit
import RxSwift
import RxCocoa


class OTConsumptionRecordsViewController: UIViewController {

    @IBOutlet weak var tvSpendingRecords: UITableView!
    var disposeBag = DisposeBag()
    var listViewModel: OTConsumptionListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. table view
        self.tvSpendingRecords.register(UINib.init(nibName: "OTMonthlyConsumptionTableViewCell", bundle: nil), forCellReuseIdentifier: OTMonthlyConsumptionTableViewCell.cellId)
        self.tvSpendingRecords.estimatedRowHeight = 64
        self.tvSpendingRecords.rowHeight = UITableView.automaticDimension
        self.tvSpendingRecords
            .rx
            .modelSelected(OTDailyConsumptionRecord.self)
            .subscribe(onNext:{[weak self] model in
                let detailsVC = OTConsumptionRecordDetailsViewController()
                detailsVC.dailyRecord = model
                self?.navigationController?.pushViewController(detailsVC, animated: true)
            }).disposed(by: disposeBag)
        
        
        // 2. View Model
        self.listViewModel = OTConsumptionListViewModel()
        self.listViewModel?
            .monthConsumption
            .bind(to: self.tvSpendingRecords.rx.items(cellIdentifier: OTMonthlyConsumptionTableViewCell.cellId, cellType: OTMonthlyConsumptionTableViewCell.self)){row, data, cell in
                // 1. Title
                let formatter = DateFormatter()
                formatter.dateFormat = "d MMM"
                cell.lbTitle.text = formatter.string(from: data.date)
                
                let sum = data.items?.map({$0.consumptionWh}).reduce(0, +) ?? 0
                // 2. caption
                formatter.dateFormat = "DDD"
                cell.lbCaption.text = formatter.string(from: data.date)
                cell.lbCaption.text = String(format: "~£%.2f", Float(sum) * 0.172)
                // 3. consumption
                cell.lbConsumption.text = String(format: "%.2fkWh", (Float(sum) / 100))
            }.disposed(by: disposeBag)
        // Do any additional setup after loading the view.
                
        self.listViewModel?.setup()
        
    }
    

}
