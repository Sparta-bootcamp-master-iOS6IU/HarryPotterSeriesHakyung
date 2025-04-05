//
//  ChapterView.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 4/1/25.
//

import UIKit
import SnapKit

final class ChapterView: UIView {
    
    // MARK: - Components

    private var vStackView = UIStackView()
    private var chaptersLabel = UILabel()
    private var chapterContents = [UILabel]()

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
    
    func configData(with chapters: [Chapter]) {
        self.chaptersLabel.text = StringConstants.LableContentView.chapters
        
        chapterContents.forEach { $0.removeFromSuperview() }
        
        self.chapterContents = chapters.map {
            let chapter = UILabel()
            chapter.text = $0.title
            chapter.font = .systemFont(ofSize: Constants.Text.fontSize14)
            chapter.textColor = Color.Text.darkGray
            vStackView.addArrangedSubview(chapter)
            return chapter
        }
    }
    
    private func configSubview() {
        addSubview(vStackView)
        
        [chaptersLabel]
            .forEach { vStackView.addArrangedSubview($0) }
        
        chapterContents
            .forEach({ vStackView.addArrangedSubview($0) })
    }
    
    private func configUI() {
        vStackView.axis = .vertical
        vStackView.spacing = Constants.Spacing.spacing8
        
        chaptersLabel.font = .systemFont(ofSize: Constants.Text.fontSize18, weight: .bold)
        chaptersLabel.textColor = Color.Text.black
    }
    
    private func configAutoLayout() {
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
