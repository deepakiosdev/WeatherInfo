//
//  WeatherViewController.swift
//  WeatherViewController
//
//  Created by Dipak Pandey on 10/09/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class WeatherViewController: UIViewController, StoryboardInitializable {

    @IBOutlet weak var btnRefresData: UIButton!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblCurrentTemperature: UILabel!
    @IBOutlet weak var lblWeatherDescription: UILabel!
    @IBOutlet weak var lblMaxTemperature: UILabel!
    @IBOutlet weak var lblMinTemperature: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    
    private let disposeBag = DisposeBag()
    var forecastVC: ForecastViewController?
    var viewModel: WeatherViewModel!
    
    // MARK: - Life Cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? ForecastViewController,
           segue.identifier == String(describing: ForecastViewController.self) {
            self.forecastVC = vc
            setupForcastBinding()
        }
    }
}


// MARK: - Binding

extension WeatherViewController {
    
    private func setupBindings() {

        viewModel
            .location
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] in
                self?.lblLocation.text = $0
            })
            .disposed(by: disposeBag)
        
        viewModel
            .temperature
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] in
                self?.lblCurrentTemperature.text = $0
            })
            .disposed(by: disposeBag)
        
        viewModel
            .weatherDescription
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] in
                self?.lblWeatherDescription.text = $0
            })
            .disposed(by: disposeBag)
        
        viewModel
            .maxTemp
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] in
                self?.lblMaxTemperature.text = $0
            })
            .disposed(by: disposeBag)
        
        viewModel
            .minTemp
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] in
                self?.lblMinTemperature.text = $0
            })
            .disposed(by: disposeBag)
        
        viewModel
            .humdity
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] in
                self?.lblHumidity.text = $0
            })
            .disposed(by: disposeBag)

        
        viewModel
            .windSpeed
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] in
                self?.lblWindSpeed.text = $0
            })
            .disposed(by: disposeBag)
        
        viewModel
            .processMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] in
                self?.lblMessage.text = $0
            })
            .disposed(by: disposeBag)

        
        viewModel
            .isFetchingData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] isFetching in
                self?.loadingView.isHidden = !isFetching
                self?.btnRefresData.isUserInteractionEnabled = !isFetching
                self?.loadingIndicator.isHidden = !isFetching

            })
            .disposed(by: disposeBag)
        
        viewModel
            .hasError
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] hasError in
                self?.loadingView.isHidden = !hasError
            })
            .disposed(by: disposeBag)
       
        btnRefresData.rx
            .tap
            .debug()
            .bind { [weak self] _ in
                self?.viewModel.fetchLocation()
        }
        .disposed(by: disposeBag)

        
    }
    
    private func setupForcastBinding() {
        viewModel
            .forecasts
            .observe(on:MainScheduler.instance)
            .bind(to: (forecastVC!.foreCastData))
            .disposed(by: disposeBag)
        
    }
}

