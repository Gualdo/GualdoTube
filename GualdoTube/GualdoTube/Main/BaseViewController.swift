//
//  BaseViewController.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 30/5/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buildButtons(selector: #selector(castButtonTapped), image: .castIcon, inset: 30),
            buildButtons(selector: #selector(searchButtonTapped), image: .magnifyingIcon, inset: 33),
            buildButtons(selector: #selector(moreButtontapped), image: .dotsIcon, inset: 33)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        
        stackView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configNavigationBar() {
        let customItemView = UIBarButtonItem(customView: horizontalStack)
        customItemView.tintColor = .clear
        navigationItem.rightBarButtonItem = customItemView
    }
    
    private func buildButtons(selector: Selector, image: UIImage?, inset: CGFloat) -> UIButton {
        lazy var navBarbutton: UIButton = {
            let button = UIButton(type: .custom)
            button.addTarget(self, action: selector, for: .touchUpInside)
            button.setImage(image, for: .normal)
            button.tintColor = .whiteColor
            let extraPadding: CGFloat = inset + 2.0
            button.imageEdgeInsets = UIEdgeInsets(top: extraPadding , left: inset, bottom: extraPadding, right: inset)
            return button
        }()
        
        return navBarbutton
    }
    
    @objc func castButtonTapped() {
        print("Cast button tapped")
    }
    
    @objc func searchButtonTapped() {
        print("Search button tapped")
    }
    
    @objc func moreButtontapped() {
        print("More button tapped")
    }
}
