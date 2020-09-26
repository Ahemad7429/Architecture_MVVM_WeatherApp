//
//  DictionaryExtension.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 24/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func toData() -> Data {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: [])
        return jsonData
    }
    
    func getLocalLocationModel() -> LocalLocation {
        let decoder = JSONDecoder()
        let model = try! decoder.decode(LocalLocation.self, from: self.toData())
        return model
    }
    
}
