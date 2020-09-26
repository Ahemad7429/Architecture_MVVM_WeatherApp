//
//  DoubleExtension.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 25/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation

extension Double {
    
    func getTemperatureString() -> String {
        let formula = (self - 273.15).rounded(toPlaces: 1)
        return "\(formula)°"
    }
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toKphString() -> String {
        let formula = (self * 3.6).rounded(toPlaces: 1)
        return "\(formula) KPH"
    }
    
    func convertToDayTime() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}
