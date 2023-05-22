//
//  HomePresenter.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func getData(list: [[Any]], sectionTitleList: [String])
}

class HomePresenter {
    
    weak var delegate: HomeViewProtocol?
    
    private var objectList: [[Any]] = []
    private var sectionTitleList: [String] = []
    
    var provider: HomeProviderProtocol
    
    init(delegate: HomeViewProtocol, provider: HomeProviderProtocol = HomeProvider()) {
        self.delegate = delegate
        self.provider = provider
#if DEBUG
        if MockManager.shared.runAppWithMock {
            self.provider = HomeProviderMock()
        }
#endif
    }
    
    @MainActor
    func getHomeObjects() async {
        objectList.removeAll()
        sectionTitleList.removeAll()
        
        async let channel = try await provider.getChannel(channelId: Constants.channelId).items
        async let videos = try await provider.getVideos(searchString: "", channelId: Constants.channelId).items
        async let playlists = try await provider.getPlaylists(channelId: Constants.channelId).items
        
        do {
            let (responseChannel, responsePlaylists, responseVideos) = await (try channel, try playlists, try videos)
            
            // Index 0
            objectList.append(responseChannel)
            sectionTitleList.append("")
            
            if let playlistId = responsePlaylists.first?.id, let playlistItems = await getPlaylistItems(playlistId: playlistId) {
                // Index 1
                objectList.append(playlistItems.items)
                sectionTitleList.append(responsePlaylists.first?.snippet.title ?? "")
            }
            
            // Index 2
            objectList.append(responseVideos)
            sectionTitleList.append("Uploads")
            
            // Index 3
            objectList.append(responsePlaylists)
            sectionTitleList.append("Created playlists")
            
            delegate?.getData(list: objectList, sectionTitleList: sectionTitleList)
        }
        catch {
            print(error)
        }
    }
    
    func getPlaylistItems(playlistId: String) async -> PlaylistItemsModel? {
        do {
            return try await provider.getPlaylistItems(playlistId: playlistId)
        } catch {
            print("Error: ", error)
            return nil
        }
    }
}
