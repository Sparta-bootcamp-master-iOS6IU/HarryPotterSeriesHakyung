//
//  BookSeriseButton.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 4/3/25.
//

import UIKit

final class BookSeriesButton: UIView {
    
    // MARK: - Delegates
    
    weak var delegate: BookSeriesButtonDelegate?
    
    // MARK: - Components

    private var hStackview = UIStackView()
    private var buttons = [UIButton]()
    private var books: [Book]?
    
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
    
    func configData(with books: [Book]) {
        if buttons.isEmpty {
            self.books = books
            self.buttons = books.enumerated().map({ index, _ in
                let button = createButton(index: index)
                hStackview.addArrangedSubview(button)
                return button
            })
        }
    }
    
    private func createButton(index: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = Int(index)
        button.setTitle("\(Int(index) + 1)", for: .normal)
        button.setTitleColor((index == 0) ? Constants.Color.white : Constants.Color.blue, for: .normal)
        button.backgroundColor = (index == 0) ? Constants.Color.blue : Constants.Color.lightGray
        button.titleLabel?.font = .boldSystemFont(ofSize: Constants.Components.buttonTitleSize)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = Constants.Components.buttonSize / 2
        
        button.snp.makeConstraints {
            $0.size.equalTo(Constants.Components.buttonSize)
        }
        return button
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        buttons.forEach { button in
            let isSelected = button == sender
            updateButtonStyle(button, isSelected: isSelected)
        }
        
        guard let books else { return }
        delegate?.buttonDidTapped(book: books[sender.tag])
    }
    
    private func updateButtonStyle(_ button: UIButton, isSelected: Bool) {
        button.backgroundColor = isSelected ? Constants.Color.blue : Constants.Color.lightGray
        button.setTitleColor(isSelected ? Constants.Color.white : Constants.Color.blue, for: .normal)
    }
    
    private func configSubview() {
        addSubview(hStackview)
    }
    
    private func configUI() {
        hStackview.axis = .horizontal
        hStackview.distribution = .equalSpacing
        hStackview.spacing = Constants.Spacing.spacing10
    }
    
    private func configAutoLayout() {
        hStackview.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
}
