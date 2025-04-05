//
//  UserDefaults.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 4/3/25.
//

import Foundation

struct DefaultsHandler {
    
    /// 더보기 / 접기 버튼의 상태를 저장한다.
    ///
    /// - Parameters:
    ///   - forKey: 변형하고 싶은 `String` 타입의 `Date`
    ///   - value: 변형하고 싶은 `String` 타입의 `Date`
    func saveExpandedState(forKey: String, value: [Bool]) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    
    /// 더보기 / 접기 버튼의 상태를 리턴한다.
    ///
    /// - Parameters:
    ///   - forKey: 변형하고 싶은 `String` 타입의 `Date`
    /// - Returns: `Key`에 알맞는 `Value` 값
    func getExpandedState(forKey: String) -> [Bool]? {
        return UserDefaults.standard.array(forKey: forKey) as? [Bool]
    }
}
