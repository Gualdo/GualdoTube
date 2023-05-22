//
//  ChannelCell.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 21/5/23.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var subscribeLabel: UILabel!
    @IBOutlet weak var bellImage: UIImageView!
    @IBOutlet weak var subscriberNumbersLabel: UILabel!
    @IBOutlet weak var channelInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(model: ChannelModel.Item) {
        channelTitle.text = model.snippet.title
        subscriberNumbersLabel.text = "\(model.statistics?.subscriberCount ?? "0") subscribers - \(model.statistics?.videoCount ?? "0") videos"
        channelInfoLabel.text = model.snippet.description
    }
}
