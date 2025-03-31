//
//  LoadError.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/31/25.
//

enum ServiceError: Error {
    case invalidFile
    case noData(error: Error)
    case decodingFailed(error: Error)
    case exception(error: Error)
    
    var errorDescription: String {
        switch self {
        case .invalidFile:
            return "파일이 존재하지 않습니다"
        case .noData:
            return "데이터가 존재하지 않습니다"
        case .decodingFailed:
            return "데이터 디코딩 오류입니다"
        case .exception:
            return "알 수 없는 에러가 발생하였습니다"
        }
    }
}
