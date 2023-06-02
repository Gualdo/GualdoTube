//
//  PlayVideoViewController.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 1/6/23.
//

import UIKit
import YouTubeiOSPlayerHelper

class PlayVideoViewController: UIViewController {
    
    var videoId: String = ""
    
    lazy var playerView: YTPlayerView = {
        let view = YTPlayerView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        view.heightAnchor.constraint(equalToConstant: 225).isActive = true
        
        return view
    }()
    
    lazy var videosTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroungColor
        configView()
        configPlayerView()
    }
    
    private func configView() {
        view.addSubview(playerView)
        view.addSubview(videosTableView)
        
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: videosTableView.topAnchor),
            videosTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            videosTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            videosTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configPlayerView() {
        let playerVars: [AnyHashable: Any] = ["playsinline": 1,
                                              "controls": 1,
                                              "autohide": 1,
                                              "showinfo": 0,
                                              "modestbranding": 0]
        
        playerView.load(withVideoId: videoId, playerVars: playerVars)
    }
}

extension PlayVideoViewController: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
