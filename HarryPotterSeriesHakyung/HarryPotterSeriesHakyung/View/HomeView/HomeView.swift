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
    
    private var contentView = UIView()
    private var titleLable = UILabel()
    
    private var scrollview = UIScrollView()
    private var contentSubView = UIView()
    private var vStackView = UIStackView()
    
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
    
    /// `HomeViewModel`의 `Publisher`인 `books`를 구독하여 데이터를 전달받는다.
    ///
    /// - Parameters:
    ///   - viewModel: `ViewController`에서 넘어온 `HomeViewModel`
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
    
    /// Update된 `[Book]` 타입의 데이터를 `UI`에 적용한다.
    ///
    /// - Parameters:
    ///   - books: Update된 `[Book]` 데이터
    private func updateUI(with books: [Book]) {
        guard let book = books.first else { return }
        configData(with: book)
        
        bookSeriesButton.configData(with: books)
        
        infoView.configData(with: book)
        
        dedicationView.configData(with: StringConstants.HomeView.dedication, contentText: book.dedication)

        let truncatedSummary = summaryView.truncateWithEllipsis(from: book.summary)
        summaryView.configData(with: StringConstants.HomeView.summary, contentText: truncatedSummary)
        
        moreLessButton.delegate = summaryView
        moreLessButton.configData(with: book)
        
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
        
        titleLable.textAlignment = .center
        titleLable.font = .systemFont(ofSize: Constants.Text.fontSize24, weight: .bold)
        titleLable.textColor = Color.Text.black
        titleLable.numberOfLines = Constants.Text.lines2
        
        scrollview.isScrollEnabled = true
        scrollview.alwaysBounceVertical = true
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.isDirectionalLockEnabled = true
        
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
