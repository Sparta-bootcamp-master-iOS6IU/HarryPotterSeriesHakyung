//
//  BookSeriseButton.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 4/3/25.
//

import UIKit
import SwiftUI

final class BookSeriseButton: UIView {
    
    // MARK: - Delegates
    
    weak var delegate: BookSeriseButtonDelegate?
    
    // MARK: - Components

    private var hStackview = UIStackView()
    private var buttons = [UIButton]()
    
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
        self.buttons = books.enumerated().map({
            let button = UIButton(type: .system)
            button.tag = Int($0.offset)
            button.setTitle("\(Int($0.offset) + 1)", for: .normal)
            
            button.setTitleColor(($0.offset == 0) ? Constants.Color.white : Constants.Color.blue, for: .normal)
            button.backgroundColor = ($0.offset == 0) ? Constants.Color.blue : Constants.Color.lightGray
            button.titleLabel?.font = .boldSystemFont(ofSize: Constants.Components.buttonTitleSize)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.layer.cornerRadius = Constants.Components.buttonSize / 2
            button.snp.makeConstraints {
                $0.size.equalTo(Constants.Components.buttonSize)
            }
            
            hStackview.addArrangedSubview(button)
            return button
        })
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        print("button tapped!!")
        for button in buttons {
            button.backgroundColor = (button == sender) ? Constants.Color.blue : Constants.Color.lightGray
            button.setTitleColor((button == sender) ? Constants.Color.white : Constants.Color.blue, for: .normal)
            if button == sender { delegate?.buttonDidTapped(index: button.tag) }
        }
        
    }
    
    private func configSubview() {
        addSubview(hStackview)
    }
    
    private func configUI() {
        hStackview.axis = .horizontal
        hStackview.distribution = .equalSpacing
        hStackview.spacing = Constants.Spacing.spacing8
    }
    
    private func configAutoLayout() {
        hStackview.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.Spacing.spacing35)
        }
    }
}



// MARK: - SwiftUI Preview
struct ViewController_Preview2: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable2()
            .edgesIgnoringSafeArea(.all)
//            .previewDevice("iPhone 16 Pro")
    }
}

struct ViewControllerRepresentable2: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> HomeViewController {
        return HomeViewController()
    }
    
    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
        // 필요하면 업데이트 로직 추가
    }
}

