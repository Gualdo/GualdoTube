//
//  BottomSheetViewController.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 24/5/23.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    lazy var opaqueView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        return view
    }()
    
    lazy var verticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroungColor
        
        view.addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 250),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStack.topAnchor.constraint(equalTo: view.topAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verticalStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        return view
    }()
    
    lazy var separator: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .whiteColor
        
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
        contentView.animateBottomSheet(show: true)
    }
    
    private func configView() {
        view.backgroundColor = .clear
        
        view.addSubview(opaqueView)
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            opaqueView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            opaqueView.topAnchor.constraint(equalTo: view.topAnchor),
            opaqueView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            opaqueView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let options = [
            ("clock", "Save to watch later"),
            ("plus.square.on.square", "Save to playlist"),
            ("arrow.down.to.line", "Download video"),
            ("arrowshape.turn.up.right", "Share"),
            ("xmark", "Cancel")
        ]
        
        createOtions(options: options)
        
        addDismissTapGesture(to: opaqueView)
    }
    
    func createOtions(options: [(String, String)]) {
        
        for option in options {
            let iconImage: UIImageView = {
                let imageView = UIImageView(image: UIImage(systemName: option.0))
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.tintColor = .whiteColor
                imageView.contentMode = .scaleAspectFit
                
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(equalToConstant: 25),
                    imageView.heightAnchor.constraint(equalToConstant: 25)
                ])
                
                return imageView
            }()
            
            let optionLabel: UILabel = {
                let label = UILabel(frame: .zero)
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = option.1
                label.textColor = .whiteColor
                label.font = UIFont.systemFont(ofSize: 17)
                return label
            }()
            
            let horizontalStack: UIStackView = {
                let stackView = UIStackView(arrangedSubviews: [iconImage,
                                                               optionLabel])
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = .horizontal
                stackView.spacing = 10
                stackView.distribution = .fill
                stackView.alignment = .center
                stackView.backgroundColor = .clear
                return stackView
            }()
            
            verticalStack.addArrangedSubview(horizontalStack)
        }
        
        addDismissTapGesture(to: verticalStack.arrangedSubviews.last)
    }
    
    private func addDismissTapGesture(to view: UIView?) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(shouldDismiss))
        view?.isUserInteractionEnabled = true
        view?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func shouldDismiss() {
        contentView.animateBottomSheet(show: false) {
            self.dismiss(animated: false)
        }
    }
}
