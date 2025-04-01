//
//  JSONLoader.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/30/25.
//

import Foundation
import UIKit

class DataService {
    
    /// fetchBooks
    ///
    /// Parameter: 해리포터 시리즈 데이터를 꺼내올 JSON file 이름
    /// Return: 해리포터 시리즈 데이터
    static func fetchBooks(from fileName: String) -> Result<[Book], ServiceError> {
        
        do {
            guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                throw ServiceError.invalidFile
            }

            let data: Data
            do {
                data = try Data(contentsOf: file)
            } catch {
                throw ServiceError.noData(error: error)
            }
            
            let decoded: APIResponse
            do {
                decoded = try JSONDecoder().decode(APIResponse.self, from: data)
                let bookResource = decoded.data.map { $0.attributes }
                return .success(bookResource)
            } catch {
                throw ServiceError.decodingFailed(error: error)
            }
        } catch let serviceError as ServiceError {
            return .failure(serviceError)
        } catch {
            return .failure(.exception(error: error))
        }
    }
}
