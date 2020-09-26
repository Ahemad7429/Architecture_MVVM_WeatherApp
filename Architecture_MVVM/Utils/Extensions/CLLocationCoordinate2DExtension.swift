//
//  CLLocationCoordinate2DExtension.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 24/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    
    func getLocationString() -> String {
        return "\(latitude),\(longitude)"
    }
    
}
