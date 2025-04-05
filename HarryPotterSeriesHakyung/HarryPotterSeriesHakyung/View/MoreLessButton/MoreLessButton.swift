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
    
    private var isExpanded: Bool!
    private var receivedText: String!
    private var receivedDataIndex: String!
    private let defaultsHandler = DefaultsHandler()
    
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
        receivedDataIndex = "\(seriseNumber)"
        receivedText = book.summary
        
        button.isHidden = receivedText.count < Constants.MoreLessButton.wordLimit
        
        getIsExpandedState()
        configButtonTitle()
        delegate?.didMoreLessButtonToggle(toggle: isExpanded, receivedText)
    }
    
    // UserDefaults
    // Key: Book index, value: [isExpended state]
    private func configButtonTitle() {
        if isExpanded {
            button.setTitle(StringConstants.MoreLessView.less, for: .normal)
        } else {
            button.setTitle(StringConstants.MoreLessView.more, for: .normal)
        }
        defaultsHandler.saveExpandedState(forKey: receivedDataIndex, value: [isExpanded])
    }
    
    private func getIsExpandedState() {
        if let value = defaultsHandler.getExpandedState(forKey: self.receivedDataIndex) {
            isExpanded = value.first!
        } else { // 앱 처음 실행
            isExpanded = false
            defaultsHandler.saveExpandedState(forKey: receivedDataIndex, value: [isExpanded])
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
    }
    
    private func configUI() {
        button.setTitleColor(Color.Button.blue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.Text.fontSize14)
        button.addTarget(self, action: #selector(buttonToggled), for: .touchUpInside)
    }
    
    private func configAutoLayout() {
        button.snp.makeConstraints {
            $0.verticalEdges.trailing.equalToSuperview()
        }
    }
}
