//
//  UserDefaults.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 4/3/25.
//

import Foundation

struct DefaultsHandler {
    func saveExpandedState(forKey: String, value: [Bool]) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    
    func getExpandedState(forKey: String) -> [Bool]? {
        return UserDefaults.standard.array(forKey: forKey) as? [Bool]
    }
}
