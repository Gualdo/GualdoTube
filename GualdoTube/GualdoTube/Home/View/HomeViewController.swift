//
//  HomeViewController.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import UIKit
import FloatingPanel

class HomeViewController: UIViewController {
    
    private var objectList: [[Any]] = []
    private var sectionTitleList: [String] = []
    
    lazy var presenter = HomePresenter(delegate: self)
    
    var fpc: FloatingPanelController?
    
    lazy var homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .backgroungColor
        tableView.separatorColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configFloatingPanel()
        
        Task {
            await presenter.getHomeObjects()
        }
    }
    
    func configView() {
        
        view.backgroundColor = .backgroungColor
        
        view.addSubview(homeTableView)
        
        NSLayoutConstraint.activate([
            homeTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        homeTableView.registerFromClass(cellClass: ChannelCell.self)
        homeTableView.registerFromClass(cellClass: VideoCell.self)
        homeTableView.registerFromClass(cellClass: PlaylistCell.self)
        homeTableView.registerFromClass(headerFooterView: SectionTitleView.self)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.contentInset = UIEdgeInsets(top: -15, left: 0, bottom: 0, right: 0)
    }
    
    private func configFloatingPanel() {
        fpc = FloatingPanelController(delegate: self)
        fpc?.isRemovalInteractionEnabled = true
        fpc?.surfaceView.grabberHandle.isHidden = true
        fpc?.layout = MyFloatingPanelLayout()
        fpc?.surfaceView.contentPadding = .init(top: -48, left: 0, bottom: -48, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        if velocity < -5 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else if velocity > 5 {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    private func presentBottomSheet() {
        let vC = BottomSheetViewController()
        vC.modalPresentationStyle = .overCurrentContext
        self.present(vC, animated: false)
    }
    
    private func presentViewPanel(with videoId: String) {
        let contentVC = PlayVideoViewController()
        contentVC.videoId = videoId
        fpc?.set(contentViewController: contentVC)
        
        if let fpc = fpc {
            present(fpc, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 || indexPath.section == 2 {
            let isLastVideo = (objectList[indexPath.section].count - 1) == indexPath.row
            return isLastVideo ? 81 : 95.0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(SectionTitleView.self)") as? SectionTitleView
        sectionView?.titleLabel.text = sectionTitleList[section]
        sectionView?.configView()
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = objectList[indexPath.section]
        var videoId = ""
        
        if let playlistItem = item as? [PlaylistItemsModel.Item] {
            videoId = playlistItem[indexPath.row].contentDetails?.videoId ?? ""
        } else if let videos = item as? [VideoModel.Item] {
            videoId = videos[indexPath.row].id ?? ""
        } else {
            return
        }
        
        presentViewPanel(with: videoId)
    }
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
            
            guard let channelCell = tableView.dequeueReusableCell(for: ChannelCell.self, in: indexPath) else { return UITableViewCell() }

            channelCell.configCell(model: channel[indexPath.row])

            return channelCell
            
        } else if let playlistItem = item as? [PlaylistItemsModel.Item] {
            
            guard let playlistItemCell = tableView.dequeueReusableCell(for: VideoCell.self, in: indexPath) else { return UITableViewCell() }
            
            playlistItemCell.configCell(model: playlistItem[indexPath.row], isLastVideo: (playlistItem.count - 1) == indexPath.row)
            playlistItemCell.didTapThreeDots = { [weak self] in
                self?.presentBottomSheet()
            }
            
            return playlistItemCell
            
        } else if let videos = item as? [VideoModel.Item] {
            
            guard let videoCell = tableView.dequeueReusableCell(for: VideoCell.self, in: indexPath) else { return UITableViewCell() }
            
            videoCell.configCell(model: videos[indexPath.row], isLastVideo: (videos.count - 1) == indexPath.row)
            videoCell.didTapThreeDots = { [weak self] in
                self?.presentBottomSheet()
            }
            
            return videoCell
            
        } else if let playlist = item as? [PlaylistsModel.Item] {
            
            guard let playlistCell = tableView.dequeueReusableCell(for: PlaylistCell.self, in: indexPath) else { return UITableViewCell() }
            
            playlistCell.configCell(model: playlist[indexPath.row], isLastItem: (playlist.count - 1) == indexPath.row)
            playlistCell.didTapThreeDots = { [weak self] in
                self?.presentBottomSheet()
            }
            
            return playlistCell
        }
        
        return UITableViewCell()
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func getData(list: [[Any]], sectionTitleList: [String]) {
        objectList = list
        self.sectionTitleList = sectionTitleList
        homeTableView.reloadData()
    }
}

extension HomeViewController: FloatingPanelControllerDelegate {
    
    func floatingPanelDidRemove(_ fpc: FloatingPanelController) {
        
    }
    
    func floatingPanelWillEndDragging(_ fpc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
        if targetState.pointee != .full {
            
        } else {
            
        }
    }
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .full
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [.full: FloatingPanelLayoutAnchor(absoluteInset: 0.0, edge: .top, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 60.0, edge: .bottom, referenceGuide: .safeArea)]
    }
}
