//
//  HarryPotterSeriseView.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/28/25.
//

import UIKit
import SnapKit
import Combine
import SwiftUI

class HarryPotterSeriseView: UIView {
    
    // MARK: - Components
    
    private var view = UIView()
    private var titleLable = UILabel()
    private var numberButton = UIButton()
    
    private var hStackView = UIStackView()
    private var imageview = UIImageView()
    private var vStackView = UIStackView()
   
    private var titleLableSmall = UILabel()

    private var hStackForAuthor = UIStackView()
    private var authorLable = UILabel()
    private var authorName = UILabel()

    private var hStackForReleased = UIStackView()
    private var releasedLable = UILabel()
    private var releasedDate = UILabel()
    
    private var hStackForPages = UIStackView()
    private var pagesLable = UILabel()
    private var pagesNumber = UILabel()
    
    private var vStackForDedication = UIStackView()
    private var dedicationLabel = UILabel()
    private var dedicationContent = UILabel()
    private var vStackForSummary = UIStackView()
    private var summaryLabel = UILabel()
    private var summaryContent = UILabel()
    
    private var books: [BookResource] = BookResource.demo()
    private var dataIndex: Int = .zero
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
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
    private func updateUI(_ books: [BookResource], _ dataIndex: Int) {
        titleLable.text = books[dataIndex].title
        numberButton.setTitle("\(dataIndex + 1)", for: .normal)
        imageview.image = UIImage(named: "harrypotter\(dataIndex + 1)")
        
        titleLableSmall.text = books[dataIndex].title
        authorName.text = books[dataIndex].author
        releasedDate.text = StringDateFormatter.formattedDateString(from: books[dataIndex].releaseDate)
        pagesNumber.text = "\(books[dataIndex].pages)"
        
        dedicationContent.text = "\(books[dataIndex].dedication)"
        summaryContent.text = "\(books[dataIndex].summary)"
    }
    
    private func configUI() {
        backgroundColor = .white
        
        // view
        addSubview(view)
        
        [titleLable, numberButton, hStackView, vStackForDedication, vStackForSummary]
            .forEach { view.addSubview($0) }
        
        // titleLable
        titleLable.text = books[dataIndex].title
        titleLable.textAlignment = .center
        titleLable.font = .systemFont(ofSize: Constants.Text.textSize24, weight: .bold)
        titleLable.textColor = Constants.Text.textColorDefault
        titleLable.numberOfLines = 2
        
        // numberButton
        numberButton.setTitle("\(dataIndex + 1)", for: .normal)
        numberButton.setTitleColor(.white, for: .normal)
        numberButton.titleLabel?.font = .boldSystemFont(ofSize: Constants.Components.buttonTitleSize)
        numberButton.backgroundColor = Constants.Components.buttonColor
        numberButton.layer.cornerRadius = Constants.Components.buttonLength / 2
        
        [imageview, vStackView]
            .forEach { hStackView.addArrangedSubview($0) }
        
        [titleLableSmall, hStackForAuthor, hStackForReleased, hStackForPages]
            .forEach { vStackView.addArrangedSubview($0) }
        
        [authorLable, authorName]
            .forEach { hStackForAuthor.addArrangedSubview($0) }
        
        [releasedLable, releasedDate]
            .forEach { hStackForReleased.addArrangedSubview($0) }
        
        [pagesLable, pagesNumber]
            .forEach { hStackForPages.addArrangedSubview($0) }
        
        // imageview
        imageview.image = UIImage(named: "harrypotter\(dataIndex + 1)")
        imageview.contentMode = .scaleAspectFit
        
        // hStackView
        hStackView.axis = .horizontal
        hStackView.alignment = .top
        hStackView.spacing = Constants.Spacing.spacing18
        
        // vStackView
        vStackView.axis = .vertical
        vStackView.alignment = .top
        vStackView.spacing = Constants.Spacing.spacing8
        
        // titleLableSmall
        titleLableSmall.text = books[dataIndex].title
        titleLableSmall.font = .systemFont(ofSize: Constants.Text.textSize20, weight: .bold)
        titleLableSmall.textColor = Constants.Text.textColorDefault
        titleLableSmall.numberOfLines = 2
        
        // hStackForAuthor
        hStackForAuthor.axis = .horizontal
        hStackForAuthor.spacing = Constants.Spacing.spacing8
        // authorLable
        authorLable.text = "Author"
        authorLable.font = .systemFont(ofSize: Constants.Text.textSize16, weight: .bold)
        authorLable.textColor = Constants.Text.textColorDefault
        // authorName
        authorName.text = books[dataIndex].author
        authorName.font = .systemFont(ofSize: Constants.Text.textSize18)
        authorName.textColor = Constants.Text.textColorDarkGray
            
        // hStackForReleased
        hStackForReleased.axis = .horizontal
        hStackForReleased.spacing = Constants.Spacing.spacing8
        // releasedLable
        releasedLable.text = "Released"
        releasedLable.font = .systemFont(ofSize: Constants.Text.textSize14, weight: .bold)
        releasedLable.textColor = Constants.Text.textColorDefault
        // releasedDate
        releasedDate.text = StringDateFormatter.formattedDateString(from: books[dataIndex].releaseDate)
        releasedDate.font = .systemFont(ofSize: Constants.Text.textSize14)
        releasedDate.textColor = Constants.Text.textColorGray
        
        // hStackForPages
        hStackForPages.axis = .horizontal
        hStackForPages.spacing = Constants.Spacing.spacing8
        // pagesLable
        pagesLable.text = "Pages"
        pagesLable.font = .systemFont(ofSize: Constants.Text.textSize14, weight: .bold)
        pagesLable.textColor = Constants.Text.textColorDefault
        // pagesNumber
        pagesNumber.text = "\(books[dataIndex].pages)"
        pagesNumber.font = .systemFont(ofSize: Constants.Text.textSize14)
        pagesNumber.textColor = Constants.Text.textColorGray
        
        [dedicationLabel, dedicationContent]
            .forEach { vStackForDedication.addArrangedSubview($0) }
        
        [summaryLabel, summaryContent]
            .forEach { vStackForSummary.addArrangedSubview($0) }
        
        // vStackForDedication
        vStackForDedication.axis = .vertical
        vStackForDedication.spacing = Constants.Spacing.spacing8
        // dedicationLabel
        dedicationLabel.text = "Dedication"
        dedicationLabel.font = .systemFont(ofSize: Constants.Text.textSize18, weight: .bold)
        dedicationLabel.textColor = Constants.Text.textColorDefault
        // dedicationContent
        dedicationContent.text = "\(books[dataIndex].dedication)"
        dedicationContent.font = .systemFont(ofSize: Constants.Text.textSize14)
        dedicationContent.textColor = Constants.Text.textColorDarkGray
        dedicationContent.numberOfLines = .zero
        
        // vStackForSummary
        vStackForSummary.axis = .vertical
        vStackForSummary.spacing = Constants.Spacing.spacing8
        // summaryLabel
        summaryLabel.text = "Summary"
        summaryLabel.font = .systemFont(ofSize: Constants.Text.textSize18, weight: .bold)
        summaryLabel.textColor = Constants.Text.textColorDefault
        // summaryContent
        summaryContent.text = "\(books[dataIndex].summary)"
        summaryContent.font = .systemFont(ofSize: Constants.Text.textSize14)
        summaryContent.textColor = Constants.Text.textColorDarkGray
        summaryContent.numberOfLines = .zero
    }
    
    private func configAutoLayout() {

        view.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        titleLable.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        numberButton.snp.makeConstraints {
            $0.width.height.equalTo(Constants.Components.buttonLength)
            $0.top.equalTo(titleLable.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        hStackView.snp.makeConstraints {
            $0.top.equalTo(numberButton.snp.bottom).offset(Constants.Spacing.spacing30)
            $0.horizontalEdges.equalToSuperview().offset(Constants.Spacing.spacing25)
            $0.height.equalTo(Constants.Components.imageViewHeight)
        }
        
        imageview.snp.makeConstraints {
            $0.width.equalTo(Constants.Components.imageViewWidth)
            $0.height.equalTo(Constants.Components.imageViewHeight)
        }
        
        vStackView.snp.makeConstraints {
            $0.top.equalTo(imageview.snp.top)
        }

        titleLableSmall.snp.makeConstraints {
            $0.top.equalTo(vStackView.snp.top)
            $0.trailing.equalTo(hStackView.snp.trailing).inset(Constants.Spacing.spacing25)
        }
        
        vStackForDedication.snp.makeConstraints {
            $0.top.equalTo(hStackView.snp.bottom).offset(Constants.Spacing.spacing24)
            $0.leading.equalTo(imageview.snp.leading)
            $0.trailing.equalToSuperview().inset(Constants.Spacing.spacing20)
        }
        
        vStackForSummary.snp.makeConstraints {
            $0.horizontalEdges.equalTo(vStackForDedication.snp.horizontalEdges)
            $0.top.equalTo(vStackForDedication.snp.bottom).offset(Constants.Spacing.spacing24)
        }
    }
    
}


// MARK: - SwiftUI Preview
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
//            .previewDevice("iPhone 16 Pro")
    }
}

struct ViewControllerRepresentable: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // 필요하면 업데이트 로직 추가
    }
}

