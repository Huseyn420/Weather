//
//  DetailTableViewCell.swift
//  Weather
//
//  Created by Гусейн Агаев on 22.11.2020.
//

import UIKit

// MARK: - detailTableViewCellModel
struct DetailTableViewCellModel {
    
    // MARK: - Public Properties
    
    let time: Double
    let temperature: Double
    let urlString: String
    let humidity: Int
}

class DetailTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private let weatherImageView = UIImageView()
    private let temperatureLabel = UILabel()
    private let timeLabel = UILabel()
    private let humidity = UILabel()

    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    // MARK: - Public Method

    override func layoutSubviews() {
        super.layoutSubviews()
        
        timeLabel.pin
            .left(10)
            .height(40)
            .vCenter()
            .sizeToFit(.height)
        
        humidity.pin
            .after(of: timeLabel, aligned: .center)
            .sizeToFit()
            .marginLeft(10)
        
        weatherImageView.pin
            .size(40)
            .after(of: humidity, aligned: .center)
            .marginLeft(10)
        
        temperatureLabel.pin
            .after(of: weatherImageView, aligned: .center)
            .right(10)
            .marginLeft(10)
            .sizeToFit(.width)
    }
    
    func configuration(data: DetailTableViewCellModel) {
        weatherImageView.loadImageUsingCache(urlString: data.urlString)
        temperatureLabel.text = String(Int(data.temperature - 273.15)) + "°C"
        humidity.text = String(data.humidity) + "%"
        timeLabel.text = timeString(dt: data.time).split(separator: "_").filter { !$0.isEmpty }.joined(separator: "\n")
    }
    
    func timeString(dt: Double) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let dateFormetter = DateFormatter()
            
        dateFormetter.dateFormat = "dd MMMM_HH:mm"
            
        return dateFormetter.string(from: date)
    }
    
    // MARK: - Private Method
    
    private func setup() {
        temperatureLabel.textAlignment = .right
        temperatureLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        temperatureLabel.textColor = UIColor.ApplicationСolor.mainText
        
        humidity.textColor = UIColor.ApplicationСolor.complementaryColor
        
        timeLabel.numberOfLines = 2
        timeLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        timeLabel.textColor = UIColor.ApplicationСolor.textColor
        backgroundColor = UIColor.ApplicationСolor.interfaceUnit
        
        [weatherImageView, temperatureLabel, timeLabel, humidity].forEach {
            contentView.addSubview($0)
        }
    }
}
