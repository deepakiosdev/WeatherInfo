//
//  ForecastViewController.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import UIKit
import RxSwift
import RxCocoa

class ForecastViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var foreCastData: BehaviorRelay<[ForecastCellViewModel]> = BehaviorRelay<[ForecastCellViewModel]>.init(value: [ForecastCellViewModel]())
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        setupCollectionView()
    }

}

// MARK: - UICollectionView 
extension ForecastViewController {
    
    private func registerCell() {
        let cellNib = UINib(nibName: String(describing: ForecastCell.self), bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: String(describing: ForecastCell.self))
    }
    
    private func setupCollectionView() {
        registerCell()
        foreCastData
            .bind(to: collectionView.rx.items(cellIdentifier: String(describing: ForecastCell.self), cellType: ForecastCell.self)) { (row, viewModel, cell) in
                cell.viewModel.accept(viewModel)
            }
            .disposed(by: disposeBag)
    }
    
}
