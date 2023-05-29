//
//  VideoCell.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 21/5/23.
//

import UIKit
import Kingfisher

class VideoCell: UITableViewCell {
    
    var didTapThreeDots: (() -> Void)?
    
    lazy var bottomConstraint = horizontalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14)
    lazy var lastVideoBottomConstraint = horizontalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
    
    lazy var videoThumbnailImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 144)
        ])
        
        return imageView
    }()
    
    lazy var videoTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "whiteColor")
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    lazy var channelNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "grayColor")
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    lazy var viewsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "grayColor")
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    lazy var verticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [videoTitleLabel,
                                                       channelNameLabel,
                                                       viewsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [videoThumbnailImage,
                                                       verticalStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var threeDotsImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dots"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(named: "whiteColor")
        
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
        
        self.backgroundColor = UIColor(named: "backgroundColor")
        self.selectionStyle = .none
        
        self.addSubview(horizontalStack)
        self.addSubview(threeDotsImage)
        
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            horizontalStack.topAnchor.constraint(equalTo: self.topAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: threeDotsImage.leadingAnchor, constant: -3),
            threeDotsImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            threeDotsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14)
        ])
    }
    
    func configCell(model: Any, isLastVideo: Bool) {
        
        if let video = model as? VideoModel.Item {
            videoThumbnailImage.kf.setImage(with: URL(string: video.snippet?.thumbnails.medium?.url ?? ""))
            videoTitleLabel.text = video.snippet?.title ?? ""
            channelNameLabel.text = video.snippet?.channelTitle ?? ""
            viewsLabel.text = "\(video.statistics?.viewCount ?? "0") views - 3 months ago"
        } else if let playlistItem = model as? PlaylistItemsModel.Item {
            videoThumbnailImage.kf.setImage(with: URL(string: playlistItem.snippet.thumbnails.medium.url))
            videoTitleLabel.text = playlistItem.snippet.title
            channelNameLabel.text = playlistItem.snippet.channelTitle
            viewsLabel.text = "332 views - 3 months ago"
        }
        
        if isLastVideo {
            lastVideoBottomConstraint.isActive = true
        } else {
            bottomConstraint.isActive = true
        }
        
        self.bringSubviewToFront(threeDotsImage)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(threeDotsTapped))
        threeDotsImage.isUserInteractionEnabled = true
        threeDotsImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func threeDotsTapped() {
        didTapThreeDots?()
    }
    
    override func prepareForReuse() {
        bottomConstraint.isActive = false
        lastVideoBottomConstraint.isActive = false
    }
}
