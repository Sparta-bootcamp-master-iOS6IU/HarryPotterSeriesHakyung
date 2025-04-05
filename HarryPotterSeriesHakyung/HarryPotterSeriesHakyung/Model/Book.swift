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
                title: "Harry Potter and the Prisoner of Azkaban",
                author: "J. K. Rowling",
                pages: 317,
                releaseDate: "1999-07-08",
                dedication: "To Jill Prewett and Aine Kiely, the Godmothers of Swing",
                summary: "When the Knight Bus crashes through the darkness and screeches to a halt in front of him, it's the start of another far from ordinary year at Hogwarts for Harry Potter. Sirius Black, escaped mass-murderer and follower of Lord Voldemort, is on the run – and they say he is coming after Harry. In his first ever Divination class, Professor Trelawney sees an omen of death in Harry's tea leaves... But perhaps most terrifying of all are the Dementors patrolling the school grounds, with their soul-sucking kiss.",
                wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Prisoner_of_Azkaban",
                chapters: [
                    Chapter(title: "1. Owl Post"),
                    Chapter(title: "2. Aunt Marge's Big Mistake"),
                    Chapter(title: "3. The Knight Bus"),
                    Chapter(title: "4. The Leaky Cauldron"),
                    Chapter(title: "5. The Dementor"),
                    Chapter(title: "6. Talons and Tea Leaves"),
                    Chapter(title: "7. The Boggart in the Wardrobe"),
                    Chapter(title: "8. Flight of the Fat Lady"),
                    Chapter(title: "9. Grim Defeat"),
                    Chapter(title: "10. The Marauder's Map"),
                    Chapter(title: "11. The Firebolt"),
                    Chapter(title: "12. The Patronus"),
                    Chapter(title: "13. Gryffindor versus Ravenclaw"),
                    Chapter(title: "14. Snape's Grudge"),
                    Chapter(title: "15. The Quidditch Final"),
                    Chapter(title: "16. Professor Trelawney's Prediction"),
                    Chapter(title: "17. Cat, Rat and Dog"),
                    Chapter(title: "18. Moony, Wormtail, Padfoot and Prongs"),
                    Chapter(title: "19. The Servant of Lord Voldemort"),
                    Chapter(title: "20. The Dementor's Kiss"),
                    Chapter(title: "21. Hermione's Secret"),
                    Chapter(title: "22. Owl Post Again")
                ]
            )
        ]
    }
}
