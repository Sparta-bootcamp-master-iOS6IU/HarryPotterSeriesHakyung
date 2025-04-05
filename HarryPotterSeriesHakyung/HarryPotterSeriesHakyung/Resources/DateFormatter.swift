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
    
    /// 원하는 형태의 데이터 포맷으로 변형한다.
    ///
    /// - Parameters:
    ///   - dateString: 변형하고 싶은 `String` 타입의 `Date`
    /// - Returns: 원하는 형태로 변형한 `String` 값
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
