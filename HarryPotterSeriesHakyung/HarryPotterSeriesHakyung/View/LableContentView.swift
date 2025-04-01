//
//  DedicationSummaryView.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 4/1/25.
//

import Foundation
import UIKit

final class LableContentView: UIView {
    
    // MARK: - Components
    
    private var label = UILabel()
    private var content = UILabel()
    
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
    
    func configData(with lableText: String, contentText: String) {
        
        label.text = "\(lableText)"
        content.text = "\(contentText)"
    }
    
    private func configSubview() {
        
        [label, content]
            .forEach { addSubview($0) }
    }
    
    private func configUI() {
        
        // label
        label.font = .systemFont(ofSize: Constants.Text.textSize18, weight: .bold)
        label.textColor = Constants.Text.textColorDefault
        
        // content
        content.font = .systemFont(ofSize: Constants.Text.textSize14)
        content.textColor = Constants.Text.textColorDarkGray
        content.numberOfLines = .zero
    }
    
    private func configAutoLayout() {
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(Constants.Spacing.spacing5)
        }
        
        content.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(Constants.Spacing.spacing8)
            $0.horizontalEdges.equalToSuperview()
            $0.leading.equalTo(label.snp.leading)
            $0.bottom.equalToSuperview().inset(Constants.Spacing.spacing5)
        }
    }
}
