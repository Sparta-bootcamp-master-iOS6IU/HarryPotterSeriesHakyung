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
    private var numberButton = UIButton()
    
    private var scrollview = UIScrollView()
    private var contentSubView = UIView()
    private var vStackView = UIStackView()
    
    // COMBINE
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Custom Views
    
    private let infoView = InfoView()
    private let dedicationView = LableContentView()
    private let summaryView = LableContentView()
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
            .receive(on: RunLoop.main)
            .sink { [weak self] books in
                guard let self = self else { return }
                let dataIndex = Int.random(in: 0..<books.count)
                self.updateUI(books, dataIndex)
            }.store(in: &subscriptions)
    }
    
    /// updateUI
    ///
    /// Update된 [BookResource] 데이터를 UI에 적용
    /// Parameter: Update된 [BookResource] 데이터
    private func updateUI(_ books: [Book], _ dataIndex: Int) {
        // HomeView
        configData(with: books[dataIndex], dataIndex)
        
        // InfoView
        infoView.configData(with: books[dataIndex], dataIndex)
        
        // LableContentView - Dedication
        dedicationView.configData(with: "Dedication", contentText: books[dataIndex].dedication)

        // LableContentView - Summary
        let summary = books[dataIndex].summary
        let truncatedSummary = summaryView.truncateWithEllipsis(from: summary)
        summaryView.configData(with: "Summary", contentText: truncatedSummary)
        
        // MoreLessButton
        moreLessButton.configData(with: books[dataIndex].summary)
        moreLessButton.delegate = summaryView
        
        // ChapterView
        chapterView.configData(with: books[dataIndex].chapters)
    }
    
    private func configData(with book: Book, _ dataIndex: Int) {
        titleLable.text = book.title
        numberButton.setTitle("\(dataIndex + 1)", for: .normal)
    }
    
    private func configSubview() {
        [contentView, scrollview]
            .forEach { addSubview($0) }
        
        [titleLable, numberButton]
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
        titleLable.font = .systemFont(ofSize: Constants.Text.textSize24, weight: .bold)
        titleLable.textColor = Constants.Text.textColorDefault
        titleLable.numberOfLines = 2
        
        // numberButton
        numberButton.setTitleColor(.white, for: .normal)
        numberButton.titleLabel?.font = .boldSystemFont(ofSize: Constants.Components.buttonTitleSize)
        numberButton.backgroundColor = Constants.Color.blue
        numberButton.layer.cornerRadius = Constants.Components.buttonLength / 2
        
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
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalTo(self.safeAreaLayoutGuide)
        }
        
        titleLable.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.Spacing.spacing10)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.Spacing.spacing20)
        }
        
        numberButton.snp.makeConstraints {
            $0.width.height.equalTo(Constants.Components.buttonLength)
            $0.top.equalTo(titleLable.snp.bottom).offset(Constants.Spacing.spacing16)
            $0.centerX.equalToSuperview()
        }
        
        scrollview.snp.makeConstraints {
            $0.top.equalTo(numberButton.snp.bottom).offset(Constants.Spacing.spacing10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
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
            $0.bottom.equalToSuperview()
        }
    }
}
