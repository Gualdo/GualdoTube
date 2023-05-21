//
//  HomeProvider.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import Foundation

protocol HomeProviderProtocol {
    func getVideos(searchString: String, channelId: String) async throws -> VideoModel
    func getChannel(channelId: String) async throws -> ChannelsModel
    func getPlaylists(channelId: String) async throws -> PlaylistsModel
    func getPlaylistItems(playlistId: String) async throws -> PlaylistItemsModel
}

class HomeProvider {
    
}

extension HomeProvider: HomeProviderProtocol {
    
    func getVideos(searchString: String, channelId: String) async throws -> VideoModel {
        var queryParams: [String: String] = ["part": "snippet", "type": "video"]
        
        if !channelId.isEmpty {
            queryParams["channelId"] = channelId
        }
        
        if !searchString.isEmpty {
            queryParams["q"] = searchString
        }
        
        let requestModel = RequestModel(endpoint: .search, queryItems: queryParams)
        
        do {
            return try await ServiceLayer.callService(requestModel, VideoModel.self)
        } catch {
            print(error)
            throw error
        }
    }
    
    func getChannel(channelId: String) async throws -> ChannelsModel {
        let queryParams: [String: String] = ["part": "snippet,statistics,brandingSettings",
                                             "id": channelId]
        
        let requestModel = RequestModel(endpoint: .channles, queryItems: queryParams)
        
        do {
            return try await ServiceLayer.callService(requestModel, ChannelsModel.self)
        } catch {
            print(error)
            throw error
        }
    }
    
    func getPlaylists(channelId: String) async throws -> PlaylistsModel {
        let queryParams: [String: String] = ["part": "snippet,contentDetails",
                                             "channelId": channelId]
        
        let requestModel = RequestModel(endpoint: .playlists, queryItems: queryParams)
        
        do {
            return try await ServiceLayer.callService(requestModel, PlaylistsModel.self)
        } catch {
            print(error)
            throw error
        }
    }
    
    func getPlaylistItems(playlistId: String) async throws -> PlaylistItemsModel {
        let queryParams: [String: String] = ["part": "snippet,id,contentDetails",
                                             "playlistId": playlistId]
        
        let requestModel = RequestModel(endpoint: .playlistItems, queryItems: queryParams)
        
        do {
            return try await ServiceLayer.callService(requestModel, PlaylistItemsModel.self)
        } catch {
            print(error)
            throw error
        }
    }
}
