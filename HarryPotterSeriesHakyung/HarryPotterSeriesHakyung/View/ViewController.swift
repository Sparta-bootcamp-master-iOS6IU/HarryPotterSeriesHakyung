//
//  ViewController.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/28/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let harryPotterView = HarryPotterSeriseView()
    private var harryPotterViewModel: HarryPotterViewModel!
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        super.loadView()
        view = harryPotterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        harryPotterViewModel = HarryPotterViewModel(books: BookResource.demo())
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
        let result = harryPotterViewModel.appDidRun()
        switch result {
        case .success(let data):
            harryPotterView.updateViewData(from: harryPotterViewModel)
            
        case .failure(let error):
            let alert = UIAlertController(
                title: "책 데이터 로드 실패",
                message: error.errorDescription,
                preferredStyle: .alert
            )
            let closeAction = UIAlertAction(
                title: "확인",
                style: .cancel,
                handler: nil
            )
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
