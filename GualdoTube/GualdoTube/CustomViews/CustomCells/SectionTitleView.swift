//
//  SectionTitleView.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 24/5/23.
//

import UIKit

class SectionTitleView: UITableViewHeaderFooterView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13.0)
        label.textColor = .whiteColor
        return label
    }()
    
    private lazy var customView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 13.0),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0)
        ])
        
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        contentView.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            customView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            customView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customView.heightAnchor.constraint(equalToConstant: 40.0),
        ])
    }
}
