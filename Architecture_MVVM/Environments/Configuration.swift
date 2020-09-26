//
//  Configuration.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 23/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation

struct Configuration {
    lazy var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.range(of: Environment.production.rawValue) != nil {
                return .production
            } else if configuration.range(of: Environment.stage.rawValue) != nil {
                return .stage
            } else if configuration.range(of: Environment.qa.rawValue) != nil {
                return .qa
            }
        }
        return .dev
    }()
}
