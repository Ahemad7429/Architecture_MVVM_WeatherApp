//
//  LocalStorageManager.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 24/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    var storedLocations: DefaultsKey<[LocalLocation]> { .init("storedLocations", defaultValue: []) }
    var temperatureUnit: DefaultsKey<String> { .init("temperatureUnit", defaultValue: "c") }
}

class LocalStorageManager {
    
    class func add(location: LocalLocation) {
        Defaults[\.storedLocations].append(location)
    }
    
    class func getLocations() -> [LocalLocation]? {
        return Defaults[\.storedLocations]
    }
    
    class func remove(location: LocalLocation) {
        Defaults[\.storedLocations].removeAll { (obj) -> Bool in
            return obj.cityName == location.cityName && obj.location == location.location
        }
    }
    
}
