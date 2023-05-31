//
//  OptionCollectionViewCell.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 30/5/23.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {
    
    lazy var optionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    func configCell(option: String) {
        
        self.backgroundColor = .clear
        
        self.addSubview(optionLabel)
        
        NSLayoutConstraint.activate([
            optionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            optionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            optionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            optionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        optionLabel.text = option
    }
}
