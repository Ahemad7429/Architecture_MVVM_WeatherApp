//
//  WeatherApiProvider.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 25/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation
import Moya

enum WeatherApiProvider {
    case getWeather(params: [String: Any])
    case getForeCast(params: [String: Any])
}

extension WeatherApiProvider: TargetType {
    
    var baseURL: URL {
        return AppConst.currentConfiguration.baseUrl.toUrl
    }
    
    var path: String {
        switch self {
        case .getWeather: return "weather"
        case .getForeCast: return "forecast"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeather, .getForeCast: return .get
        }
    }
    
    var sampleData: Data {
       return Data()
    }
    
    var task: Task {
        switch self {
        case .getWeather(var params), .getForeCast(var params):
            params["appid"] = AppConst.currentConfiguration.openWeatherApiKey
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}



