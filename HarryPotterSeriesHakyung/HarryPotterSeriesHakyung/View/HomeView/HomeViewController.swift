//
//  ViewController.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/28/25.
//

import UIKit
import Combine
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let homeView = HomeView()
    private var homeViewModel: HomeViewModel!
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        super.loadView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel(books: Book.demo())
        homeView.bookSeriesButton.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadBooks()
    }
    
    // MARK: - Methods
    
    private func loadBooks() {
        checkBookResource()
    }
    
    private func checkBookResource() {
        let result = homeViewModel.appDidRun()
        switch result {
        case .success(_):
            homeView.updateViewData(from: homeViewModel)
            
        case .failure(let error):
            let alert = UIAlertController(
                title: StringConstants.Alert.failure,
                message: error.errorDescription,
                preferredStyle: .alert
            )
            let closeAction = UIAlertAction(
                title: StringConstants.Alert.cancel,
                style: .cancel,
                handler: nil
            )
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: BookSeriesButtonDelegate {
    func buttonDidTapped(book: Book) {
        self.homeViewModel.selectBook(book)
    }
}
