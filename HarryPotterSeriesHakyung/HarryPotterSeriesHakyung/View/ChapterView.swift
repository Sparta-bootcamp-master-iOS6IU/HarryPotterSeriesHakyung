//
//  ChapterView.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 4/1/25.
//

import UIKit

protocol CustomViewDelegate: AnyObject {
    func didUpdateData(with chapters: [Chapter])
}

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
        self.chaptersLabel.text = "Chapters"
        
        chapterContents.forEach { $0.removeFromSuperview() }
        
        self.chapterContents = chapters.map {
            let chapter = UILabel()
            chapter.text = $0.title
            chapter.font = .systemFont(ofSize: Constants.Text.textSize14)
            chapter.textColor = Constants.Text.textColorDarkGray
            vStackView.addArrangedSubview(chapter)
            return chapter
        }
        vStackView.layoutIfNeeded()
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
        
        chaptersLabel.font = .systemFont(ofSize: Constants.Text.textSize18, weight: .bold)
        chaptersLabel.textColor = Constants.Text.textColorDefault
    }
    
    private func configAutoLayout() {
        
        vStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        
        chaptersLabel.snp.makeConstraints {
            $0.top.equalTo(vStackView.snp.top)
            $0.horizontalEdges.equalToSuperview()
        }
        
        chapterContents.forEach {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview()
            }
        }
    }
}
