//
//  CityDetailsViewModel.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 25/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation

class CityDetailsViewModel {
    
    var localLocation: LocalLocation!
    var weatherDetails: WeatherModel!
    var weatherForecastDetails: WeatherForecast?
    var selectedIndex: Int = 0
    
    func getWeatherForcastData(success: @escaping () -> Void, failure: @escaping (_ message: String) -> Void) {
        guard let lat = weatherDetails.coord?.lat, let lon = weatherDetails.coord?.lon else { return }
        let params: [String : Any] = ["lat": lat,
                                      "lon": lon]
        NetworkService.shared.callService(NetworkService.shared.weatherApiProvider, type: WeatherApiProvider.getForeCast(params: params), success: { (response: WeatherForecast) in
            self.weatherForecastDetails = response
            success()
        }) { (error: AppError) in
            failure(error.message)
        }
    }
    
}
