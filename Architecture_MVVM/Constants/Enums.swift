//
//  enums.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 23/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    
    case main = "Main"
    case locationPicker = "LocationPicker"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardId) as! T
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
    
}

enum WeatherTypes: String {
    
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case showerRain = "shower rain"
    case rain = "rain"
    case thunderstorm = "thunderstorm"
    case snow = "snow"
    case mist = "mist"
    case haze = "haze"
    
    var icon: UIImage? {
        switch self {
        case .clearSky: return UIImage(named: "img_sunny")
        case .fewClouds: return UIImage(named: "img_cloud_day")
        case .scatteredClouds: return UIImage(named: "img_cloudy_night")
        case .brokenClouds: return UIImage(named: "img_cloudy")
        case .showerRain, .rain: return UIImage(named: "img_rain")
        case .thunderstorm: return UIImage(named: "img_storm")
        case .snow: return UIImage(named: "img_snow")
        case .mist, .haze: return UIImage(named: "img_clear_night")
        }
    }
    
}

