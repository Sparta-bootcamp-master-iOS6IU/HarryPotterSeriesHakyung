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
    
    func configData(with text: String, dataIndex: Int) {
        self.receivedText = text
        self.receivedDataIndex = "\(dataIndex)"
        
        button.isHidden = text.count < 450
        
        getIsExpandedState()
        configButtonTitle()
        delegate?.didMoreLessButtonToggle(toggle: isExpanded, receivedText)
    }
    
    // UserDefaults
    // Key: Book index, value: [isExpended state]
    private func configButtonTitle() {
        if isExpanded {
            button.setTitle("접기", for: .normal)
        } else {
            button.setTitle("더 보기", for: .normal)
        }
        UserDefaults.standard.set([isExpanded], forKey: self.receivedDataIndex)
    }
    
    private func getIsExpandedState() {
        if let value = UserDefaults.standard.array(forKey: self.receivedDataIndex) as? [Bool] {
            isExpanded = value.first!
        } else { // 앱 처음 실행
            isExpanded = false
            UserDefaults.standard.set([isExpanded], forKey: self.receivedDataIndex)
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
