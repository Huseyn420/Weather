//
//  ViewController.swift
//  Weather
//
//  Created by Гусейн Агаев on 20.11.2020.
//

import UIKit
import RxSwift
import RxCocoa
import PinLayout

final class SearchViewController: UIViewController {

    // MARK: - Private Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let searchViewModel = SearchViewModel(networkManager: NetworkManager())
    
    private let containerView  = UIView()
    private let weatherImageView = UIImageView()
    private let temperatureLabel = UILabel()
    private let cityNameLabel = UILabel()
    private let detailButton = UIButton(type: .system)
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        linkToViewModel()
        setup()
    }
    
    // MARK: - Public Method

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.pin
            .top(view.pin.safeArea.top)
            .horizontally(20)
            .height(120)
        
        detailButton.pin
            .below(of: containerView)
            .horizontally(20)
            .marginTop(10)
            .height(40)
        
        temperatureLabel.pin
            .left(8)
            .height(50)
            .right(containerView.center.x)
            .vCenter(-20)
        
        cityNameLabel.pin
            .after(of: temperatureLabel, aligned: .top)
            .height(25)
            .right(8)
            .marginLeft(8)
        
        weatherImageView.pin
            .size(cityNameLabel.frame.height)
            .below(of: cityNameLabel, aligned: .center)
        
        detailButton.applyGradient(colours: UIColor.ApplicationСolor.buttonBackground)
    }

    // MARK: - Private Method

    private func setup() {
        view.applyGradient(colours: UIColor.ApplicationСolor.background)
        
        navigationItem.searchController = searchController
        searchController.searchBar.searchTextField.backgroundColor = UIColor.ApplicationСolor.textFieldBackground
        searchController.searchBar.searchTextField.placeholder = "Search"
        
        containerView.backgroundColor = UIColor.ApplicationСolor.interfaceUnit
        containerView.layer.cornerRadius = 20
        
        detailButton.setTitle("Detail", for: .normal)
        detailButton.setTitleColor(UIColor.ApplicationСolor.textColor, for: .normal)
        detailButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 17)
        detailButton.layer.cornerRadius = 10
        detailButton.layer.masksToBounds = true
        detailButton.addTarget(self, action: #selector(didTapDetailButton), for: .touchUpInside)
        
        temperatureLabel.font = UIFont.systemFont(ofSize: 50, weight: .medium)
        temperatureLabel.textAlignment = .left
        temperatureLabel.textColor = UIColor.ApplicationСolor.mainText
        temperatureLabel.text = "t°C"

        cityNameLabel.font = UIFont.systemFont(ofSize: 25, weight : .semibold)
        cityNameLabel.textAlignment = .center
        cityNameLabel.textColor = UIColor.ApplicationСolor.textColor
        cityNameLabel.text = "City Name"
        
        [containerView, detailButton].forEach {
            view.addSubview($0)
        }
        
        [weatherImageView, temperatureLabel, cityNameLabel].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func linkToViewModel() {
        
        searchController.searchBar.rx.text
            .bind(to: searchViewModel.searchText)
            .disposed(by: disposeBag)
        
        searchViewModel.cityName
            .bind(to: cityNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        searchViewModel.temperature
            .bind(to: temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        searchViewModel.weatherImage.subscribe { [weak self] (urlString) in
            self?.weatherImageView.loadImageUsingCache(urlString: urlString)
        }.disposed(by: disposeBag)
        
        searchViewModel.alertMessage.subscribe { [weak self] (messange) in
            DispatchQueue.main.async() {
                self?.errorMessages(message: messange)
            }
        }.disposed(by: disposeBag)
    }
    
    @objc private func didTapDetailButton() {
        let detailView = DetailViewController()
        detailView.navigationItem.title = cityNameLabel.text
        navigationController?.pushViewController(detailView, animated: true)
    }
}
