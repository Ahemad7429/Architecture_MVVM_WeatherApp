//
//  ForecastListCollectionViewCell.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 25/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import UIKit

class ForecastListCollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView {

    // MARK:- Outlets
    
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var forecastTempLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK:- Functions
    var weatherDetails: WeatherModel? {
        didSet {
            forecastImageView.image = nil
            let icon = weatherDetails?.weather?.first?.icon ?? "50d"
            let imageString = "https://openweathermap.org/img/w/\(icon).png"
            forecastImageView.setImage(with: imageString, indicator: true)
            forecastTempLabel.text = weatherDetails?.main?.temp?.getTemperatureString()
            timeLabel.text = weatherDetails?.dt?.convertToDayTime()
        }
    }

    
}
