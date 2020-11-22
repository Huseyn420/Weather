//
//  NetworkManager.swift
//  Weather
//
//  Created by Гусейн Агаев on 20.11.2020.
//

import Foundation
import RxSwift

final class NetworkManager {
    
    enum urlPart {
        case currentWeather
        case hourlyWeather
        
        var path: String {
            switch self {
            case .currentWeather:
                return "data/2.5/weather?q="
            case .hourlyWeather:
                return "/data/2.5/forecast?q="
            }
        }
    }
    
    // MARK: - Private Properties

    private let apiKey = "4a9aac8d84a5f9c3a0802a0688725256"
    private let baseURL = "https://api.openweathermap.org/"
    
    // MARK: - Public Method
    
    func search<T: Codable>(for city: String, type: urlPart) -> Observable<T> {
        let urlString = baseURL + type.path + "\(city)&APIKEY=" + apiKey
        
        guard let url = URL(string: urlString) else {
            return Observable.never()
        }
        
        return Observable<T>.create { observer in
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                    return
                }
            
                do {
                    let result = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(result)
                } catch let error {
                    observer.onError(error)
                }
                
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
