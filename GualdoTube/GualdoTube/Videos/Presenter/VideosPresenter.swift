//
//  VideosPresenter.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 25/5/23.
//

import Foundation

protocol VideosViewProtocol: AnyObject {
    func getVideos(videosList: [VideoModel.Item])
}

class VideosPresenter {
    
    private weak var delegate: VideosViewProtocol?
    private var provider: VideosProviderProtocol
    
    init(delegate: VideosViewProtocol, provider: VideosProviderProtocol = VideosProvider()) {
        self.provider = provider
        self.delegate = delegate
        
        #if DEBUG
        if MockManager.shared.runAppWithMock {
            self.provider = VideosProviderMock()
        }
        #endif
    }
    
    @MainActor
    func getVideos() async {
        do {
            let videos = try await provider.getVideos(channelId: Constants.channelId).items
            delegate?.getVideos(videosList: videos)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
