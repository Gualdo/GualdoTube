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
    
    lazy var presenter = PlayVideoPresenter(delegate: self)
    
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
        configTableView()
        configPlayerView()
        loadDataFromApi()
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
    
    private func configTableView() {
        // Delegates
        videosTableView.delegate = self
        videosTableView.dataSource = self
        
        // Register Cells
        videosTableView.registerFromClass(cellClass: VideoHeaderCell.self)
        videosTableView.registerFromClass(cellClass: VideoFullWidthCell.self)
        
        // Cell height
        videosTableView.rowHeight = UITableView.automaticDimension
        videosTableView.estimatedRowHeight = 60
    }
    
    private func loadDataFromApi() {
        Task { [weak self] in
            await self?.presenter.getVideos(videoId)
        }
    }
}

extension PlayVideoViewController: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}

extension PlayVideoViewController: PlayVideoViewProtocol {
    
    func getRelatedVideosFinished() {
        print("response")
        videosTableView.reloadData()
    }
}

extension PlayVideoViewController: UITableViewDelegate {
    
}

extension PlayVideoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.relatedVideoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.relatedVideoList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = presenter.relatedVideoList[indexPath.section]
        
        if indexPath.section == 0 {
            guard let video = item[indexPath.row] as? VideoModel.Item,
                  let videoHeaderCell = tableView.dequeueReusableCell(for: VideoHeaderCell.self, in: indexPath)
            else { return UITableViewCell() }
            
            videoHeaderCell.configCell(videoModel: video, channelModel: presenter.channelModel)
            videoHeaderCell.selectionStyle = .none
            
            return videoHeaderCell
        } else {
            guard let video = item[indexPath.row] as? VideoModel.Item,
                  let videoFullWidthCell = tableView.dequeueReusableCell(for: VideoFullWidthCell.self, in: indexPath)
            else { return UITableViewCell() }
            
            videoFullWidthCell.configCell(model: video)
            
            return videoFullWidthCell
        }
    }
}
