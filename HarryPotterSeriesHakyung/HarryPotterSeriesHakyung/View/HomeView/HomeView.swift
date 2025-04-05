//
//  HarryPotterSeriseView.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/28/25.
//

import UIKit
import SnapKit
import Combine


final class HomeView: UIView {
    
    // MARK: - Components
    
    // UI
    private var contentView = UIView()
    private var titleLable = UILabel()
    
    private var scrollview = UIScrollView()
    private var contentSubView = UIView()
    private var vStackView = UIStackView()
    
    // COMBINE
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Custom Views
    
    var bookSeriesButton = BookSeriesButton()
    private let infoView = InfoView()
    private let dedicationView = LabelContentView()
    private let summaryView = LabelContentView()
    private let chapterView = ChapterView()
    private let moreLessButton = MoreLessButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configSubview()
        configUI()
        configAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    /// updateViewData
    ///
    /// Published된 [BookResource]를 Subscribe하여 Receive 한다.
    /// Parameter: ViewController에서 넘어온 HarryPotterViewModel
    func updateViewData(from viewModel: HomeViewModel) {
        viewModel.books
            .receive(on: DispatchQueue.main)
            .sink { [weak self] books in
                guard let self else { return }
                self.updateUI(with: books)
            }.store(in: &subscriptions)
        
        viewModel.selectedBook
            .receive(on: DispatchQueue.main)
            .sink { [weak self] book in
                guard let book else { return }
                self?.updateUI(with: [book])
            }.store(in: &subscriptions)
    }
    
    /// updateUI
    ///
    /// Update된 [BookResource] 데이터를 UI에 적용
    /// Parameter: Update된 [BookResource] 데이터
    private func updateUI(with books: [Book]) {
        guard let book = books.first else { return }
        
        // HomeView
        configData(with: book)
        
        // BookSeriseButton
        bookSeriesButton.configData(with: books)
        
        // InfoView
        infoView.configData(with: book)
        
        // LableContentView - Dedication
        dedicationView.configData(with: StringConstants.Home.dedication, contentText: book.dedication)

        // LableContentView - Summary
        let truncatedSummary = summaryView.truncateWithEllipsis(from: book.summary)
        summaryView.configData(with: StringConstants.Home.summary, contentText: truncatedSummary)
        
        // MoreLessButton
        moreLessButton.delegate = summaryView
        moreLessButton.configData(with: book)
        
        // ChapterView
        chapterView.configData(with: book.chapters)
    }
    
    private func configData(with book: Book) {
        titleLable.text = book.title
    }
    
    private func configSubview() {
        [contentView, scrollview]
            .forEach { addSubview($0) }
        
        [titleLable, bookSeriesButton]
            .forEach { contentView.addSubview($0) }
        
        
        [contentSubView, vStackView]
            .forEach { scrollview.addSubview($0) }
        
        [infoView, dedicationView, summaryView, moreLessButton, chapterView]
            .forEach { vStackView.addArrangedSubview($0) }
        
        vStackView.bringSubviewToFront(moreLessButton)
    }
    
    private func configUI() {
        backgroundColor = .white
        
        // titleLable
        titleLable.textAlignment = .center
        titleLable.font = .systemFont(ofSize: Constants.Text.fontSize24, weight: .bold)
        titleLable.textColor = Color.Text.black
        titleLable.numberOfLines = Constants.Text.lines2
        
        // scrollview
        scrollview.isScrollEnabled = true
        scrollview.alwaysBounceVertical = true
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.isDirectionalLockEnabled = true
        
        // vStackView
        vStackView.axis = .vertical
        vStackView.spacing = Constants.Spacing.spacing24
    }
    
    private func configAutoLayout() {
        
        contentView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        titleLable.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.Spacing.spacing10)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.Spacing.spacing20)
        }
        
        bookSeriesButton.snp.makeConstraints {
            $0.top.equalTo(titleLable.snp.bottom).offset(Constants.Spacing.spacing18)
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Constants.Components.buttonSize)
        }
        
        scrollview.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.bottom).offset(Constants.Spacing.spacing20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        scrollview.contentLayoutGuide.snp.makeConstraints {
            $0.edges.equalTo(contentSubView)
        }
        
        contentSubView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(vStackView.snp.height)
        }
        
        vStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.Spacing.spacing10)
            $0.horizontalEdges.equalToSuperview().inset(Constants.Spacing.spacing25)
        }
    }
}
