//
//  DetailViewController.swift
//  Weather
//
//  Created by Гусейн Агаев on 22.11.2020.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    
    // MARK: - Public Properties
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let identifier = "DetailTableViewCell"
    
    private var detailViewModel: DetailViewModel?
    private let disposeBag = DisposeBag()
    
    private var cellsData = BehaviorRelay<[DetailTableViewCellModel]>(value: [])
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        linkToViewModel()
        setup()
    }
    
    // MARK: - Public Method
    
    private func setup() {
        tableView.backgroundColor = .none
        view.applyGradient(colours: UIColor.ApplicationСolor.background)
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: identifier)
                
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    private func linkToViewModel() {
        detailViewModel = DetailViewModel(networkManager: NetworkManager(), city: navigationItem.title ?? "")
        detailViewModel?.hourlyWeather.subscribe({ [weak self] (hourlyWeather) in
            var result = [DetailTableViewCellModel]()
            
            if let hourly = hourlyWeather.element?.list {
                for i in hourly {
                    let model = DetailTableViewCellModel(time: i.dt,
                                                         temperature: i.main.temp,
                                                         urlString: i.imageURL,
                                                         humidity: i.main.humidity)
                    result.append(model)
                }
                
                result.sort { $0.time < $1.time }
                self?.cellsData.accept(result)
                
                DispatchQueue.main.async { () -> Void in
                    self?.tableView.reloadData()
                }
            }
        }).disposed(by: disposeBag)
        
        detailViewModel?.alertMessage.subscribe { [weak self] (messange) in
            DispatchQueue.main.async() {
                self?.errorMessages(message: messange)
            }
        }.disposed(by: disposeBag)
    }
}



// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Public Method
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? DetailTableViewCell else {
            fatalError("Cell should be not nil")
        }
        
        cell.configuration(data: cellsData.value[indexPath.row])
        cell.separatorInset = UIEdgeInsets.zero
        
        return cell
    }
}
