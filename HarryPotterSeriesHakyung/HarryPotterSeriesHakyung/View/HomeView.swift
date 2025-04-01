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
    private var view = UIView()
    private var contentView = UIView()
    private var titleLable = UILabel()
    private var numberButton = UIButton()
    
    private var scrollview = UIScrollView()
    private var contentSubView = UIView()
    private var vStackView = UIStackView()
    
    // BOOK DATA
    private var books: [Book] = Book.demo()
    private var dataIndex: Int = .zero
    
    // COMBINE
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Custom Views
    
    private let infoView = InfoView()
    private let dedicationView = LableContentView()
    private let summaryView = LableContentView()
    private let chapterView = ChapterView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configSubview()
        configUI()
        configData(with: books[dataIndex])
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
    func updateViewData(from viewModel: HarryPotterViewModel) {
        viewModel.books
            .receive(on: RunLoop.main)
            .sink { [unowned self] books in
                self.dataIndex = Int.random(in: 0..<books.count)
                updateUI(books, dataIndex)
            }.store(in: &subscriptions)
    }
    
    /// updateUI
    ///
    /// Update된 [BookResource] 데이터를 UI에 적용
    /// Parameter: Update된 [BookResource] 데이터
    private func updateUI(_ books: [Book], _ dataIndex: Int) {
        // HomeView
        titleLable.text = books[dataIndex].title
        numberButton.setTitle("\(dataIndex + 1)", for: .normal)
        
        // InfoView
        infoView.configData(with: books[dataIndex], dataIndex)
        
        // LableContentView - Dedication
        dedicationView.configData(with: "Dedication", contentText: books[dataIndex].dedication)
        
        // LableContentView - Summary
        summaryView.configData(with: "Summary", contentText: books[dataIndex].summary)
        
        // ChapterView
        chapterView.configData(with: books[dataIndex].chapters)
    }
    
    private func configSubview() {

        addSubview(view)
        
        [contentView, scrollview]
            .forEach { view.addSubview($0) }
        
        [titleLable, numberButton]
            .forEach { contentView.addSubview($0) }
        
        [contentSubView, vStackView]
            .forEach { scrollview.addSubview($0) }
        
        [infoView, dedicationView, summaryView, chapterView]
            .forEach { vStackView.addArrangedSubview($0) }
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
        numberButton.backgroundColor = Constants.Components.buttonColor
        numberButton.layer.cornerRadius = Constants.Components.buttonLength / 2
        
        scrollview.isScrollEnabled = true
        scrollview.alwaysBounceVertical = true
        scrollview.showsVerticalScrollIndicator = true
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.isDirectionalLockEnabled = true
        
        vStackView.axis = .vertical
        vStackView.spacing = Constants.Spacing.spacing24
    }
    
    private func configAutoLayout() {
        
        view.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        titleLable.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(Constants.Spacing.spacing10)
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
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentSubView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalTo(vStackView.snp.bottom)
        }
        
        vStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Constants.Spacing.spacing25)
            $0.verticalEdges.equalToSuperview()
        }
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(vStackView.snp.top).offset(Constants.Spacing.spacing30)
            $0.height.equalTo(Constants.Components.imageViewHeight)
        }
        
        dedicationView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(Constants.Spacing.spacing24)
            $0.horizontalEdges.equalToSuperview()
        }
        
        summaryView.snp.makeConstraints {
            $0.top.equalTo(dedicationView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        chapterView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configData(with book: Book) {
        
        titleLable.text = books[dataIndex].title
        numberButton.setTitle("\(dataIndex + 1)", for: .normal)
    }
}
