//
//  Environment.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 23/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation

enum Environment: String {
    
    case dev = "Development"
    case production = "Production"
    case stage = "Stage"
    case qa = "QA"
    
    var baseUrl: String {
        switch self {
        case .dev, .stage, .production, .qa: return "https://api.openweathermap.org/data/2.5/"
        }
    }
    
    var openWeatherApiKey: String {
        switch self {
        case .dev, .production, .stage, .qa: return "2b2ce1e7f8579916057a00e9092859ad"
        }
    }
    
}
