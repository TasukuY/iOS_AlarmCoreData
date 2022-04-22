//
//  DateHelper.swift
//  AlarmCoreData
//
//  Created by Tasuku Yamamoto on 4/21/22.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let formatDates = DateFormatter()
        let formatTimes = DateFormatter()
        formatDates.dateFormat = "MMM d"
        formatTimes.dateFormat = "h:mm a"
        let datesString = formatDates.string(from: self)
        let timesString = formatTimes.string(from: self)
        
        return "\(datesString) at \(timesString)"
    }
}
