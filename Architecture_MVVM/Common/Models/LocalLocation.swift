//
//  LocalLocation.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 24/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

struct LocalLocation: Codable, DefaultsSerializable {
    
    var cityName: String
    var location: String
    
}
