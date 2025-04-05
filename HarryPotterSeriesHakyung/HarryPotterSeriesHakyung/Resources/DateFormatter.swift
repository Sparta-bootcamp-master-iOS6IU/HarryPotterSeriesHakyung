//
//  DateFormatter.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/31/25.
//

import Foundation

enum DateFormat {
    static let defaultFormat = "yyyy-MM-dd"
    static let format1 = "MMMM dd, yyyy"
}

struct StringDateFormatter {
    
    /// formattedDateString
    ///
    /// Parameter: 변형하고 싶은 String type의 Date
    /// Return: String type으로 들어온 Date를 원하는 형태로 변형한 값
    static func formattedDateString(from dateString: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.defaultFormat
        
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = DateFormat.format1
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
}
