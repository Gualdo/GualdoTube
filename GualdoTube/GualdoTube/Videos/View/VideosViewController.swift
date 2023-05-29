//
//  VideosViewController.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import UIKit

class VideosViewController: UIViewController {
    
    lazy var presenter = VideosPresenter(delegate: self)
    
    lazy var videosTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .backgroungColor
        tableView.separatorColor = .clear
        return tableView
    }()
    
    var videosList: [VideoModel.Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        Task {
            await presenter.getVideos()
        }
    }
    
    func configTableView() {
        
        view.backgroundColor = .backgroungColor
        
        view.addSubview(videosTableView)
        
        NSLayoutConstraint.activate([
            videosTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            videosTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videosTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            videosTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        videosTableView.registerFromClass(cellClass: VideoCell.self)
        
        videosTableView.delegate = self
        videosTableView.dataSource = self
    }
    
    private func presentBottomSheet() {
        let vC = BottomSheetViewController()
        vC.modalPresentationStyle = .overCurrentContext
        self.present(vC, animated: false)
    }
}

extension VideosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isLastVideo = (videosList.count - 1) == indexPath.row
        return isLastVideo ? 81 : 95.0
    }
}

extension VideosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = videosList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else { return UITableViewCell() }
        
        cell.configCell(model: video, isLastVideo: (videosList.count - 1) == indexPath.row)
        cell.didTapThreeDots = { [weak self] in
            self?.presentBottomSheet()
        }
        
        return cell
    }
}

extension VideosViewController: VideosViewProtocol {
    
    func getVideos(videosList: [VideoModel.Item]) {
        self.videosList = videosList
        videosTableView.reloadData()
    }
}
