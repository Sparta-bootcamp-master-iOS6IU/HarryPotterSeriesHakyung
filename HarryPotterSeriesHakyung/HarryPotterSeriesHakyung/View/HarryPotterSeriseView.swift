//
//  HarryPotterSeriseView.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/28/25.
//

import UIKit
import SwiftUI
import SnapKit

class HarryPotterSeriseView: UIView {
    
    private var view = UIView()
    private var titleLable = UILabel()
    private var numberButton = UIButton()
    private let books = JSONLoader.fetchBooks(from: "data")
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configUI()
        configAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = .white
        
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLable, numberButton]
            .forEach { view.addSubview($0) }
        
        titleLable.text = books?[0].title
        titleLable.textAlignment = .center
        titleLable.font = .systemFont(ofSize: 24, weight: .bold)
        titleLable.textColor = .black
        titleLable.numberOfLines = 2
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        
        numberButton.setTitle("1", for: .normal)
        numberButton.setTitleColor(.white, for: .normal)
        numberButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        numberButton.backgroundColor = .systemBlue
        numberButton.layer.cornerRadius = Constraints.buttonLength / 2
        numberButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configAutoLayout() {

        view.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        titleLable.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        numberButton.snp.makeConstraints {
            $0.width.height.equalTo(Constraints.buttonLength)
            $0.top.equalTo(titleLable.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

struct Constraints {
    static let buttonLength: CGFloat = 48
}
