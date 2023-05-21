//
//  HomePresenter.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func getData(list: [[Any]])
}

class HomePresenter {
    
    weak var delegate: HomeViewProtocol?
    
    private var objectList: [[Any]] = []
    
    var provider: HomeProviderProtocol
    
    init(delegate: HomeViewProtocol, provider: HomeProviderProtocol = HomeProvider()) {
        self.delegate = delegate
        self.provider = provider
    }
    
    func getHomeObjects() async {
        objectList.removeAll()
        
        do {
            let channel = try await provider.getChannel(channelId: Constants.channelId).items
            let videos = try await provider.getVideos(searchString: "", channelId: Constants.channelId).items
            let playlists = try await provider.getPlaylists(channelId: Constants.channelId).items
            let playlistItems = try await provider.getPlaylistItems(playlistId: playlists.first?.id ?? "").items
            
            objectList.append(channel)
            objectList.append(playlistItems)
            objectList.append(videos)
            objectList.append(playlists)
        }
        catch {
            print(error)
        }
    }
}
