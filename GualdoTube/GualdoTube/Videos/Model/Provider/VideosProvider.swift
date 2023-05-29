//
//  VideosProvider.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 25/5/23.
//

import Foundation

protocol VideosProviderProtocol: AnyObject {
    func getVideos(channelId: String) async throws -> VideoModel
}

class VideosProvider: VideosProviderProtocol {
    
    func getVideos(channelId: String) async throws -> VideoModel {
        var queryParams: [String: String] = ["part": "snippet", "type": "video", "maxResults": "50"]
        
        if !channelId.isEmpty {
            queryParams["channelId"] = channelId
        }
        
        let requestModel = RequestModel(endpoint: .search, queryItems: queryParams)
        
        do {
            return try await ServiceLayer.callService(requestModel, VideoModel.self)
        } catch {
            print(error)
            throw error
        }
    }
}
