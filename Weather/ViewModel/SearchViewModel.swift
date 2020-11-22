//
//  SearchViewModel.swift
//  Weather
//
//  Created by Гусейн Агаев on 20.11.2020.
//

import RxSwift
import RxCocoa

final class SearchViewModel {

    // MARK: - Private Properties
    
    private let networkManager: NetworkManager
    private let weatherData: Observable<WeatherData>
    
    // MARK: - Public Properties
    
    let cityName: Observable<String>
    let temperature: Observable<String>
    let weatherImage: Observable<String>
    let alertMessage: Observable<String>
    
    var searchText = BehaviorRelay<String?>(value: "")
    
    
    // MARK: - Initialization
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        let _alertMessage = PublishSubject<String>()
        self.alertMessage = _alertMessage.asObservable()
        
        weatherData = searchText.asObservable()
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { (searchString) -> Observable<WeatherData> in
                guard let city = searchString, !(city.isEmpty) else {
                    return Observable.empty()
                }
                
                let result = networkManager.search(for: city, type: .currentWeather).catchError { (error) -> Observable<WeatherData> in
                    _alertMessage.onNext(error.localizedDescription)
                    return Observable.empty()
                }
                
                return result
            }
            .share(replay: 1)
        
        cityName = weatherData.map { $0.name }
        temperature = weatherData.map { String(Int($0.main.temp - 273.15)) + "°C" }
        weatherImage = weatherData.map({ $0.imageURL })
    }
}
