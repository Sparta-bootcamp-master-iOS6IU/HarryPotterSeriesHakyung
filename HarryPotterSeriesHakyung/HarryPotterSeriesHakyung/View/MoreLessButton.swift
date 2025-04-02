//
//  MoreLessButton.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 4/2/25.
//

import UIKit
import SnapKit

final class MoreLessButton: UIView {
    
    // MARK: - Delegates
    
    weak var delegate: MoreLessButtonDelegate?

    // MARK: - Components

    var button = UIButton()
    
    private var isExpanded: Bool = false
    private var receivedText: String!
    
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
    
    func configData(with text: String) {
        self.receivedText = text
        button.isHidden = text.count < 450
        configButtonTitle()
    }
    
    private func configButtonTitle() {
        if isExpanded {
            button.setTitle("접기", for: .normal)
        } else {
            button.setTitle("더 보기", for: .normal)
        }
    }
    
    @objc
    private func buttonToggled() {
        isExpanded.toggle()
        configButtonTitle()
        delegate?.didMoreLessButtonToggle(toggle: isExpanded, receivedText)
    }
    
    private func configSubview() {
        addSubview(button)
        bringSubviewToFront(button)
    }
    
    private func configUI() {
        button.setTitleColor(Constants.Color.blue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(buttonToggled), for: .touchUpInside)
    }
    
    private func configAutoLayout() {
        button.snp.makeConstraints {
            $0.verticalEdges.trailing.equalToSuperview()
        }
    }
}
