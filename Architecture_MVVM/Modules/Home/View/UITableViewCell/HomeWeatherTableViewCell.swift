//
//  HomeWeatherTableViewCell.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 24/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import UIKit
import Hero

class HomeWeatherTableViewCell: UITableViewCell, NibLoadableView, ReusableView {
    
    // MARK:- Outlets
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // MARK:- Variables
    
    var localLocation: LocalLocation!
    var weatherModel: WeatherModel?
    var isRequestingWeather = false
    var forceRefreshCell = false
    
    // MARK:- Functions
    
    func setupTransistionData(index: Int) {
        cityNameLabel.hero.id = "h_city_\(index)"
        weatherTypeLabel.hero.id = "h_weatherType_\(index)"
        temperatureLabel.hero.id = "h_temperature_\(index)"
        weatherImageView.hero.id = "h_weatherImage_\(index)"
    }
    
    func configureCell(location: LocalLocation) {
        if localLocation != nil {
            if localLocation.location != location.location {
                forceRefreshCell = true
            }
        }
        localLocation = location
        setInitialData()
        updateCellUI()
    }
    
    private func setInitialData() {
        if weatherModel == nil {
            cityNameLabel.text = localLocation.cityName
            weatherTypeLabel.text = ""
            temperatureLabel.text = "-- --°"
        }
    }
    
    private func updateCellUI() {
        if forceRefreshCell {
            getWeatherDetails()
            return
        }
        if let weatherDetails = weatherModel {
            weatherTypeLabel.text = weatherDetails.weather?.first?.weatherDescription?.capitalized
            weatherImageView.image = WeatherTypes(rawValue: weatherDetails.weather?.first?.weatherDescription ?? "")?.icon ?? UIImage(named: "img_cloud_day")
            temperatureLabel.text = weatherDetails.main?.temp?.getTemperatureString()
        } else {
            if !isRequestingWeather {
                getWeatherDetails()
            }
        }
    }
    
    private func getWeatherDetails() {
        isRequestingWeather = true
        let coordinates = localLocation.location
        let params = ["lat": coordinates.getCoordinates.lat,
                      "lon": coordinates.getCoordinates.lon]
        NetworkService.shared.callService(NetworkService.shared.weatherApiProvider, type: WeatherApiProvider.getWeather(params: params), success: { (model: WeatherModel) in
            self.isRequestingWeather = false
            self.forceRefreshCell = false
            self.weatherModel = model
            self.updateCellUI()
        }) { (error) in
            print(error)
        }
    }
    
}
