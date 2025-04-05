//
//  InfoView.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 4/1/25.
//

import UIKit
import SnapKit

final class InfoView: UIView {
    
    // MARK: - Components
    
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
    
    func configData(with book: Book) {
        guard let seriseNumber = book.seriseNumber else { return }
        imageview.image = UIImage(named: "\(Image.bookName)\(seriseNumber)")
        titleLableSmall.text = book.title
        authorName.text = book.author
        releasedDate.text = StringDateFormatter.formattedDateString(from: book.releaseDate)
        pagesNumber.text = "\(book.pages)"
    }
    
    private func configSubview() {
        
        addSubview(hStackView)
        
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
    }
    
    private func configUI() {
        
        // [hStackView]
        hStackView.axis = .horizontal
        hStackView.alignment = .firstBaseline
        hStackView.spacing = Constants.Spacing.spacing18

        // imageview
        imageview.contentMode = .scaleAspectFit
        
        // [vStackView]
        vStackView.axis = .vertical
        vStackView.alignment = .top
        vStackView.spacing = Constants.Spacing.spacing8
        
        // titleLableSmall
        titleLableSmall.font = .systemFont(ofSize: Constants.Text.fontSize20, weight: .bold)
        titleLableSmall.textColor = Color.Text.black
        titleLableSmall.numberOfLines = 2
        
        // [hStackForAuthor]
        hStackForAuthor.axis = .horizontal
        hStackForAuthor.spacing = Constants.Spacing.spacing8
        
        // authorLable
        authorLable.text = StringConstants.BookInfo.author
        authorLable.font = .systemFont(ofSize: Constants.Text.fontSize16, weight: .bold)
        authorLable.textColor = Color.Text.black
        
        // authorName
        authorName.font = .systemFont(ofSize: Constants.Text.fontSize18)
        authorName.textColor = Color.Text.darkGray
        
        // [hStackForReleased]
        hStackForReleased.axis = .horizontal
        hStackForReleased.spacing = Constants.Spacing.spacing8
        
        // releasedLable
        releasedLable.text = StringConstants.BookInfo.released
        releasedLable.font = .systemFont(ofSize: Constants.Text.fontSize14, weight: .bold)
        releasedLable.textColor = Color.Text.black
        
        // releasedDate
        releasedDate.font = .systemFont(ofSize: Constants.Text.fontSize14)
        releasedDate.textColor = Color.Text.gray
        
        // [hStackForPages]
        hStackForPages.axis = .horizontal
        hStackForPages.spacing = Constants.Spacing.spacing8
        
        // pagesLable
        pagesLable.text = StringConstants.BookInfo.pages
        pagesLable.font = .systemFont(ofSize: Constants.Text.fontSize14, weight: .bold)
        pagesLable.textColor = Color.Text.black
        
        // pagesNumber
        pagesNumber.font = .systemFont(ofSize: Constants.Text.fontSize14)
        pagesNumber.textColor = Color.Text.gray
    }
    
    private func configAutoLayout() {
        
        hStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
        }
        
        imageview.snp.makeConstraints {
            $0.width.equalTo(Constants.Components.imageViewWidth)
            $0.height.equalTo(Constants.Components.imageViewHeight)
        }
    }
}
