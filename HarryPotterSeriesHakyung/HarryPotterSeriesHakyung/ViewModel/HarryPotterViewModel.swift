//
//  HarryPotterViewModel.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/31/25.
//

import Foundation
import Combine

final class HarryPotterViewModel {
    
    init(books: [BookResource]) {
        self.books = CurrentValueSubject(books)
    }
    
    // Output: Data
    let books: CurrentValueSubject<[BookResource], Never>
    
    // Input: User Action(= App Runed)
    func appDidRun() -> Result<[BookResource], ServiceError> {
        let result = DataService.fetchBooks(from: "data")
        switch result {
        case .success(let data):
            books.send(data)
        case .failure(let error):
            print(error.errorDescription)
        }
        return result
    }
}
