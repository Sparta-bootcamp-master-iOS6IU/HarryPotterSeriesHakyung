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
    
    let books: CurrentValueSubject<[Book], Never>
    let selectedBook: CurrentValueSubject<Book?, Never>
    
    // MARK: - Init
    
    init(books: [Book]) {
        self.books = CurrentValueSubject(books)
        self.selectedBook = CurrentValueSubject(nil)
    }
    
    // MARK: - Methods
    
    /// `User`가 `App`을 실행시, 데이터를 불러와 `UI`에 보여준다.
    ///
    /// - Returns: 성공시 `[Book]`데이터, 실패시 `ServiceError` 리턴
    func loadData() -> Result<[Book], ServiceError> {
        let result = DataService.fetchBooks(from: File.fileName)
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
