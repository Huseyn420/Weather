//
//  Detail.ViewModel.swift
//  Weather
//
//  Created by Гусейн Агаев on 22.11.2020.
//

import RxSwift
import RxCocoa

final class DetailViewModel {

    // MARK: - Properties
    
    private let networkManager: NetworkManager
    let hourlyWeather: Observable<HourlyWeather>
    let alertMessage: Observable<String>
    
    // MARK: - Initialization
    
    init(networkManager: NetworkManager, city: String) {
        let _alertMessage = PublishSubject<String>()
        
        self.alertMessage = _alertMessage.asObservable()
        self.networkManager = networkManager
    
        hourlyWeather = networkManager.search(for: city, type: .hourlyWeather).catchError { (error) -> Observable<HourlyWeather> in
                    _alertMessage.onNext(error.localizedDescription)
                    return Observable.empty()
                }
    }
}
