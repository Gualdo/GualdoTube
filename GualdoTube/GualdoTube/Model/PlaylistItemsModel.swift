//
//  PlaylistItemsModel.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import Foundation

// MARK: - PlaylistItemsModel
struct PlaylistItemsModel: Codable {
    let kind: String
    let etag: String
    let items: [Item]
    let pageInfo: PageInfo
    
    // MARK: - Item
    struct Item: Codable {
        let kind: String
        let etag: String
        let id: String
        let snippet: Snippet
        let contentDetails: ContentDetails?
        
        // MARK: - Snippet
        struct Snippet: Codable {
            let publishedAt: String
            let channelId: String
            let title: String
            let description: String
            let channelTitle: String
            let playlistId: String
            let videoOwnerChannelTitle: String
            let videoOwnerChannelId: String
            let position: Int
            let thumbnails: Thumbnails
            let resourceId: ResourceID
            
            // MARK: - Thumbnails
            struct Thumbnails: Codable {
                let defaultSize: Default
                let medium: Default
                let high: Default
                let standard: Default
                let maxres: Default
                
                enum CodingKeys: String, CodingKey {
                    case defaultSize = "default"
                    case medium
                    case high
                    case standard
                    case maxres
                }
                
                // MARK: - Default
                struct Default: Codable {
                    let url: String
                    let width: Int
                    let height: Int
                }
            }
            
            // MARK: - ResourceID
            struct ResourceID: Codable {
                let kind: String
                let videoId: String
            }
        }
        
        // MARK: - ContentDetails
        struct ContentDetails: Codable {
            let videoId: String?
            let videoPublishedAt: String?
        }
    }
    
    // MARK: - PageInfo
    struct PageInfo: Codable {
        let totalResults: Int
        let resultsPerPage: Int
    }
}
