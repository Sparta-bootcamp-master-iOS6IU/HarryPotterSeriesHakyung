//
//  HarryPotterViewModel.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/31/25.
//

import Foundation
import Combine

final class HomeViewModel {
    
    // MARK: - Properties
    
    // Output: Data
    let books: CurrentValueSubject<[Book], Never>
    let selectedBook: CurrentValueSubject<Book?, Never>
    
    // MARK: - Init
    
    init(books: [Book]) {
        self.books = CurrentValueSubject(books)
        self.selectedBook = CurrentValueSubject(nil)
    }
    
    // MARK: - Methods
    
    // Input: User Action(= App Did Run)
    func appDidRun() -> Result<[Book], ServiceError> {
        let result = DataService.fetchBooks(from: "data")
        switch result {
        case .success(let data):
            books.send(data)
        case .failure(let error):
            print(error.errorDescription)
        }
        return result
    }
    
    func selectBook(_ book: Book) {
        selectedBook.send(book)
    }
}
