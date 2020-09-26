//
//  DateExtension.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 24/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation

extension Date {

    func toString(format: String = "MM/dd/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    func getMessageString() -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "Today"
        }
        
        if calendar.isDateInYesterday(self) {
            return "Yesterday"
        }
        let seperatorDateFormatter: DateFormatter = DateFormatter()
        seperatorDateFormatter.dateStyle = DateFormatter.Style.medium
        return seperatorDateFormatter.string(from: self)
    }
    
}
