//
//  LoadError.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/31/25.
//

/// LoadError
///
/// 파일 / 데이터 로드 에러
enum LoadError: Error {
    case invalidFile
    case noData
    case decodingFailed
    
    var errorDescription: String {
        switch self {
        case .invalidFile:
            return "Invalid File"
        case .noData:
            return "No Data"
        case .decodingFailed:
            return "Decoding Failed"
        }
    }
}
