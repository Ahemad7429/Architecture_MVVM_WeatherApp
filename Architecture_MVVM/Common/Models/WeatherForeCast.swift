//
//  WeatherForeCast.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 25/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct WeatherForecast: Codable {
    var cod: String?
    var message, cnt: Int?
    var list: [WeatherModel]?
    var city: City?
}

// MARK: - City
struct City: Codable {
    var id: Int?
    var name: String?
    var coord: Coord?
    var country: String?
    var population, timezone, sunrise, sunset: Double?
}

