//
//  ChannelCell.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 22/5/23.
//

import UIKit
import Kingfisher

class ChannelCell: UITableViewCell {
    
    lazy var bannerImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 51/2
        return imageView
    }()
    
    lazy var profileImageContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(profileImage)
        
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 51),
            profileImage.widthAnchor.constraint(equalToConstant: 51),
            profileImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        return view
    }()
    
    lazy var channelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "whiteColor")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    lazy var subscribeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "grayColor")
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "SUBSCRIBED"
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    lazy var bellImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bell"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "grayColor")
        return imageView
    }()
    
    lazy var subscribeBellContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(subscribeLabel)
        view.addSubview(bellImage)
        
        NSLayoutConstraint.activate([
            subscribeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subscribeLabel.topAnchor.constraint(equalTo: view.topAnchor),
            subscribeLabel.trailingAnchor.constraint(equalTo: bellImage.leadingAnchor, constant: -8),
            subscribeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bellImage.centerYAnchor.constraint(equalTo: subscribeLabel.centerYAnchor),
            bellImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bellImage.heightAnchor.constraint(equalToConstant: 18),
            bellImage.widthAnchor.constraint(equalToConstant: 16)
        ])
        
        return view
    }()
    
    lazy var subscriptionContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(subscribeBellContainer)
        
        NSLayoutConstraint.activate([
            subscribeBellContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subscribeBellContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            subscribeBellContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -9)
        ])
        
        return view
    }()
    
    lazy var subscriberNumbersLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "whiteColor")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    lazy var channelInfoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "grayColor")
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.numberOfLines = 2
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    lazy var chevronRightImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(named: "grayColor")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var infoChevronContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(channelInfoLabel)
        view.addSubview(chevronRightImage)
        
        NSLayoutConstraint.activate([
            channelInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            channelInfoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 9),
            channelInfoLabel.trailingAnchor.constraint(equalTo: chevronRightImage.leadingAnchor, constant: -3),
            channelInfoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -9),
            chevronRightImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chevronRightImage.heightAnchor.constraint(equalToConstant: 20),
            chevronRightImage.widthAnchor.constraint(equalToConstant: 10),
            chevronRightImage.centerYAnchor.constraint(equalTo: channelInfoLabel.centerYAnchor)
        ])
        
        return view
    }()
    
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageContainer,
                                                       channelTitle,
                                                       subscriptionContainer,
                                                       subscriberNumbersLabel,
                                                       infoChevronContainer])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor(named: "backgroundColor")
        return stackView
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
        
        self.addSubview(bannerImage)
        self.addSubview(profileStackView)
        
        NSLayoutConstraint.activate([
            bannerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bannerImage.topAnchor.constraint(equalTo: self.topAnchor),
            bannerImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bannerImage.heightAnchor.constraint(equalToConstant: 104),
            profileStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            profileStackView.topAnchor.constraint(equalTo: bannerImage.bottomAnchor),
            profileStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            profileStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func configCell(model: ChannelModel.Item) {
        channelTitle.text = model.snippet.title
        subscriberNumbersLabel.text = "\(model.statistics?.subscriberCount ?? "0") subscribers - \(model.statistics?.videoCount ?? "0") videos"
        channelInfoLabel.text = model.snippet.description
        bannerImage.kf.setImage(with: URL(string: model.brandingSettings.image.bannerExternalUrl))
        profileImage.kf.setImage(with: URL(string: model.snippet.thumbnails.medium.url))
    }
}
