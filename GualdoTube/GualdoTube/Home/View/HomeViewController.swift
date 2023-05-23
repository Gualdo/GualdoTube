//
//  HomeViewController.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var tableViewHome: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "backgroundColor")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var presenter = HomePresenter(delegate: self)
    
    private var objectList: [[Any]] = []
    private var sectionTitleList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        
        Task {
            await presenter.getHomeObjects()
        }
    }
    
    func configTableView() {
        
        view.addSubview(tableViewHome)
        
        NSLayoutConstraint.activate([
            tableViewHome.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableViewHome.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewHome.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableViewHome.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableViewHome.register(ChannelCell.self, forCellReuseIdentifier: "\(ChannelCell.self)")
        tableViewHome.register(VideoCell.self, forCellReuseIdentifier: "\(VideoCell.self)")
        
        let nibPlaylist = UINib(nibName: "\(PlaylistCell.self)", bundle: nil)
        tableViewHome.register(nibPlaylist, forCellReuseIdentifier: "\(PlaylistCell.self)")
        
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = objectList[indexPath.section]
        
        if let channel = item as? [ChannelModel.Item] {
            
            guard let channelCell = tableView.dequeueReusableCell(withIdentifier: "\(ChannelCell.self)", for: indexPath) as? ChannelCell else {
                return UITableViewCell()
            }

            channelCell.configCell(model: channel[indexPath.row])

            return channelCell
            
        } else if let playlistItem = item as? [PlaylistItemsModel.Item] {
            
            guard let playlistItemCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else {
                return UITableViewCell()
            }
            
            playlistItemCell.configCell(model: playlistItem[indexPath.row])
            
            return playlistItemCell
            
        } else if let videos = item as? [VideoModel.Item] {
            
            guard let videoCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else {
                return UITableViewCell()
            }
            
            videoCell.configCell(model: videos[indexPath.row])
            
            return videoCell
            
        } else if let playlist = item as? [PlaylistsModel.Item] {
            
            guard let playlistCell = tableView.dequeueReusableCell(withIdentifier: "\(PlaylistCell.self)", for: indexPath) as? PlaylistCell else {
                return UITableViewCell()
            }
            
            return playlistCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleList[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 || indexPath.section == 2 {
            return 95.0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func getData(list: [[Any]], sectionTitleList: [String]) {
        objectList = list
        self.sectionTitleList = sectionTitleList
        tableViewHome.reloadData()
    }
}
