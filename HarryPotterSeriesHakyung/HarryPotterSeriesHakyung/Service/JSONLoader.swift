//
//  JSONLoader.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/30/25.
//

import Foundation

class JSONLoader {
    
    /// fetchBooks(from: )
    ///
    /// 해리포터 시리즈 데이터를 가져오는 함수
    static func fetchBooks(from fileName: String) -> [BookResource]? {
        guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print(LoadError.invalidFile)
            return nil
        }
        
        guard let data = try? Data(contentsOf: file) else {
            print(LoadError.noData)
            return nil
        }
        
        do {
            let decoded = try JSONDecoder().decode(RootData.self, from: data)
            let bookResource = decoded.data.map { $0.attributes }
            return bookResource
        } catch {
            print(LoadError.decodingFailed, error)
            return nil
        }
    }
}
