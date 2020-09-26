//
//  DataExtension.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 24/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation

extension Data {
    
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
    
}
