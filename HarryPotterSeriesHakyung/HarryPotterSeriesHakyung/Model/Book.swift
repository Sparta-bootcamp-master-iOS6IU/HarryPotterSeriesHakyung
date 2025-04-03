//
//  BookResource.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/28/25.
//

import Foundation

struct Book: Codable {
    var seriseNumber: Int? = nil
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case pages
        case releaseDate = "release_date"
        case dedication
        case summary
        case wiki
        case chapters
    }
}

struct DataItem: Codable {
    var attributes: Book
}

struct APIResponse: Codable {
    var data: [DataItem]
}

extension Book {
    static func demo() -> [Book] {
        return [
            Book(
                title: "nil",
                author: "nil",
                pages: 0,
                releaseDate: "nil",
                dedication: "nil",
                summary: "nil",
                wiki: "nil",
                chapters: [
                    Chapter(title: "nil"),
                    Chapter(title: "nil"),
                ]
            )
        ]
    }
}
