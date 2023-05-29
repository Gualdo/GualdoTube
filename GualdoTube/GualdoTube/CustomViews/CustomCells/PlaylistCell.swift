//
//  PlaylistCell.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 21/5/23.
//

import UIKit
import Kingfisher

class PlaylistCell: UITableViewCell {
    
    var didTapThreeDots: (() -> Void)?
    
    lazy var videoImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 195)
        ])
        
        return imageView
    }()
    
    lazy var videoTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .whiteColor
        return label
    }()
    
    lazy var videoCountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .grayColor
        return label
    }()
    
    lazy var infoVerticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [videoTitleLabel,
                                                       videoCountLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var overlayVideoCountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .whiteColor
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    lazy var overlayIconImage: UIImageView = {
        let imageView = UIImageView(image: .textAlignLeft)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .whiteColor
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        return imageView
    }()
    
    lazy var overlayVerticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [overlayVideoCountLabel,
                                                       overlayIconImage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10
        
        stackView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        return stackView
    }()
    
    lazy var overlayView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.9)
        view.addSubview(overlayVerticalStack)
        
        NSLayoutConstraint.activate([
            overlayVerticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            overlayVerticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }()
    
    lazy var threeDotsImage: UIImageView = {
        let imageView = UIImageView(image: .dotImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .whiteColor
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 13),
            imageView.widthAnchor.constraint(equalToConstant: 13)
        ])
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        
        self.backgroundColor = .backgroungColor
        self.selectionStyle = .none
        
        self.addSubview(videoImage)
        self.addSubview(infoVerticalStack)
        self.addSubview(overlayView)
        self.addSubview(threeDotsImage)
        
        NSLayoutConstraint.activate([
            videoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
            videoImage.topAnchor.constraint(equalTo: self.topAnchor),
            videoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13),
            infoVerticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
            infoVerticalStack.topAnchor.constraint(equalTo: videoImage.bottomAnchor, constant: 13),
            infoVerticalStack.trailingAnchor.constraint(equalTo: threeDotsImage.leadingAnchor, constant: -3),
            overlayView.centerYAnchor.constraint(equalTo: videoImage.centerYAnchor),
            overlayView.trailingAnchor.constraint(equalTo: videoImage.trailingAnchor),
            overlayView.heightAnchor.constraint(equalTo: videoImage.heightAnchor, multiplier: 1),
            overlayView.widthAnchor.constraint(equalToConstant: 150),
            threeDotsImage.centerYAnchor.constraint(equalTo: infoVerticalStack.centerYAnchor),
            threeDotsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14)
        ])
    }
    
    func configCell(model: PlaylistsModel.Item, isLastItem: Bool) {
        
        videoImage.kf.setImage(with: URL(string: model.snippet.thumbnails.medium.url))
        videoTitleLabel.text = model.snippet.title
        videoCountLabel.text = "\(model.contentDetails.itemCount) videos"
        overlayVideoCountLabel.text = String(model.contentDetails.itemCount)
        
        infoVerticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: isLastItem ? 0 : -35).isActive = true
        
        self.sendSubviewToBack(self.contentView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(threeDotsTapped))
        threeDotsImage.isUserInteractionEnabled = true
        threeDotsImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func threeDotsTapped() {
        didTapThreeDots?()
    }
}
