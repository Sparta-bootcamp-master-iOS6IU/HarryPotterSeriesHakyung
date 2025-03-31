//
//  BookResource.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/28/25.
//

import Foundation

struct BookResource: Codable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: URL?
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

struct Chapter: Codable {
    let title: String
}

struct DataItem: Codable {
    let attributes: BookResource
}

struct RootData: Codable {
    let data: [DataItem]
}
