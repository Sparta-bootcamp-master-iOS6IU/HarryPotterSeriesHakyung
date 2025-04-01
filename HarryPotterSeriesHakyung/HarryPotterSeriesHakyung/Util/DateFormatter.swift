//
//  DateFormatter.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/31/25.
//

import Foundation

struct StringDateFormatter {
    
    /// formattedDateString
    ///
    /// Parameter: 변형하고 싶은 String type의 Date
    /// Return: String type으로 들어온 Date를 원하는 형태로 변형한 값
    static func formattedDateString(from dateString: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "MMMM dd, yyyy"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
}
