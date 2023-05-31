//
//  TabsView.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 30/5/23.
//

import UIKit

protocol TabsViewProtocol: AnyObject {
    func didSelectOption(index: Int)
}

class TabsView: UIView {
    
    weak private var delegate: TabsViewProtocol?
    
    private var options: [String] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collection.backgroundColor = .backgroungColor
        
        collection.dataSource = self
        collection.delegate = self
        
        collection.register(OptionCollectionViewCell.self, forCellWithReuseIdentifier: "\(OptionCollectionViewCell.self)")
        
        return collection
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configCollectionView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func buildView(delegate: TabsViewProtocol, options: [String]) {
        self.delegate = delegate
        self.options = options
        collectionView.reloadData()
    }
    
    private func configCollectionView() {
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension TabsView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectOption(index: indexPath.row)
    }    
}

extension TabsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(OptionCollectionViewCell.self)", for: indexPath) as? OptionCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configCell(option: options[indexPath.row])
        
        return cell
    }
}

extension TabsView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = options[indexPath.row]
        label.font = UIFont.systemFont(ofSize: 16)
        let extraPadding: CGFloat = 20
        return CGSize(width: label.intrinsicContentSize.width + extraPadding, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
