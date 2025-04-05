//
//  JSONLoader.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/30/25.
//

import Foundation
import UIKit

class DataService {
    
    /// 파일 이름으로 데이터를 불러오고, 불러오기 실패시 경우에 따라 에러를 `throw`한다.
    ///
    /// - Parameters:
    ///   - fileName: 해리포터 시리즈 데이터를 꺼내올 `JSON` 파일 이름
    /// - Returns: 성공시 해리포터 시리즈 데이터, 실패시 `ServiceError` 리턴
    static func fetchBooks(from fileName: String) -> Result<[Book], ServiceError> {
        
        do {
            guard let file = Bundle.main.url(forResource: fileName, withExtension: File.json) else {
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
                    let books = decoded.data.enumerated().map {
                        var book = $0.element.attributes
                        book.seriseNumber = $0.offset + 1
                        return book
                }
                return .success(books)
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
