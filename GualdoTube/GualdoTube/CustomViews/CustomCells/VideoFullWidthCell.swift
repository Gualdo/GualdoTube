//
//  VideoFullWidthCell.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 2/6/23.
//

import UIKit

class VideoFullWidthCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(model: VideoModel.Item) {
        
    }
}
