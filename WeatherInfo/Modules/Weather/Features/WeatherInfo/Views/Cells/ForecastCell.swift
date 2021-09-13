//
//  ForecastCell.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import UIKit
import RxSwift
import RxCocoa

class ForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    
    var viewModel: BehaviorRelay<ForecastCellViewModel> =  BehaviorRelay<ForecastCellViewModel>.init(value: ForecastCellViewModel("", temperature: "", description: ""))
    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupBindings()
    }
}


extension ForecastCell {
    
    func setupBindings() {
        
        viewModel.subscribe(
            onNext: { [weak self] model in
                self?.lblDateTime.text = model.dateTime
                self?.lblDescription.text = model.description
                self?.lblTemperature.text = model.temperature
            }
        )
        .disposed(by: disposeBag)
    }
}
