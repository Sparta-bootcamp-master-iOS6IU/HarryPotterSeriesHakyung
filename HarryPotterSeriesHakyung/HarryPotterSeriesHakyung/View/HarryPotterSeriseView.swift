//
//  HarryPotterSeriseView.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/28/25.
//

import UIKit
import SnapKit
import Combine

class HarryPotterSeriseView: UIView {
    
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
    
    private var books: [BookResource] = BookResource.demo()
    private var dataIndex: Int = 0
    
    private var subscriptions = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configUI()
        configAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    func updateUI(_ books: [BookResource], _ dataIndex: Int) {
        titleLable.text = books[dataIndex].title
        numberButton.setTitle("\(dataIndex + 1)", for: .normal)
        imageview.image = UIImage(named: "harrypotter\(dataIndex + 1)")
        titleLableSmall.text = books[dataIndex].title
        authorName.text = books[dataIndex].author
        releasedDate.text = StringDateFormatter.formattedDateString(from: books[dataIndex].releaseDate)
        pagesNumber.text = "\(books[dataIndex].pages)"
    }
    
    private func configUI() {
        backgroundColor = .white
        
        // view
        addSubview(view)
        
        [titleLable, numberButton, hStackView]
            .forEach { view.addSubview($0) }
        
        // titleLable
        titleLable.text = books[dataIndex].title
        titleLable.textAlignment = .center
        titleLable.font = .systemFont(ofSize: Constraints.Text.textSize24, weight: .bold)
        titleLable.textColor = Constraints.Text.textColorDefault
        titleLable.numberOfLines = 2
        
        // numberButton
        numberButton.setTitle("\(dataIndex + 1)", for: .normal)
        numberButton.setTitleColor(.white, for: .normal)
        numberButton.titleLabel?.font = .boldSystemFont(ofSize: Constraints.Components.buttonTitleSize)
        numberButton.backgroundColor = Constraints.Components.buttonColor
        numberButton.layer.cornerRadius = Constraints.Components.buttonLength / 2
        
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
        hStackView.alignment = .firstBaseline
        hStackView.spacing = Constraints.Spacing.spacing18
        
        // vStackView
        vStackView.axis = .vertical
        vStackView.alignment = .top
        vStackView.spacing = Constraints.Spacing.spacing8
        
        // titleLableSmall
        titleLableSmall.text = books[dataIndex].title
        titleLableSmall.font = .systemFont(ofSize: Constraints.Text.textSize20, weight: .bold)
        titleLableSmall.textColor = Constraints.Text.textColorDefault
        titleLableSmall.numberOfLines = 2
        
        // hStackForAuthor
        hStackForAuthor.axis = .horizontal
        hStackForAuthor.spacing = Constraints.Spacing.spacing8
        // authorLable
        authorLable.text = "Author"
        authorLable.font = .systemFont(ofSize: Constraints.Text.textSize16, weight: .bold)
        authorLable.textColor = Constraints.Text.textColorDefault
        // authorName
        authorName.text = books[dataIndex].author
        authorName.font = .systemFont(ofSize: Constraints.Text.textSize18)
        authorName.textColor = Constraints.Text.textColorDarkGray
            
        // hStackForReleased
        hStackForReleased.axis = .horizontal
        hStackForReleased.spacing = Constraints.Spacing.spacing8
        // releasedLable
        releasedLable.text = "Released"
        releasedLable.font = .systemFont(ofSize: Constraints.Text.textSize14, weight: .bold)
        releasedLable.textColor = Constraints.Text.textColorDefault
        // releasedDate
        releasedDate.text = StringDateFormatter.formattedDateString(from: books[dataIndex].releaseDate)
        releasedDate.font = .systemFont(ofSize: Constraints.Text.textSize14)
        releasedDate.textColor = Constraints.Text.textColorGray
        
        // hStackForPages
        hStackForPages.axis = .horizontal
        hStackForPages.spacing = Constraints.Spacing.spacing8
        // pagesLable
        pagesLable.text = "Pages"
        pagesLable.font = .systemFont(ofSize: Constraints.Text.textSize14, weight: .bold)
        pagesLable.textColor = Constraints.Text.textColorDefault
        // pagesNumber
        pagesNumber.text = "\(books[dataIndex].pages)"
        pagesNumber.font = .systemFont(ofSize: Constraints.Text.textSize14)
        pagesNumber.textColor = Constraints.Text.textColorGray
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
            $0.width.height.equalTo(Constraints.Components.buttonLength)
            $0.top.equalTo(titleLable.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        hStackView.snp.makeConstraints {
            $0.top.equalTo(numberButton.snp.bottom).offset(Constraints.Spacing.spacing30)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Constraints.Components.imageViewHeight)
        }
        
        imageview.snp.makeConstraints {
            $0.top.equalTo(hStackView.snp.top)
            $0.leading.equalTo(hStackView.snp.leading).offset(Constraints.Spacing.spacing25)
            $0.width.equalTo(Constraints.Components.imageViewWidth)
            $0.height.equalTo(Constraints.Components.imageViewHeight)
        }
        
        vStackView.snp.makeConstraints {
            $0.top.equalTo(imageview.snp.top)
        }

        titleLableSmall.snp.makeConstraints {
            $0.top.equalTo(vStackView.snp.top)
            $0.trailing.equalTo(hStackView.snp.trailing).inset(Constraints.Spacing.spacing25)
        }
    }
    
}
