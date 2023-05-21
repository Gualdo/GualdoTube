//
//  PlaylistsModel.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 19/5/23.
//

import Foundation

// MARK: - PlaylistModel
struct PlaylistsModel: Decodable {
    let kind: String
    let etag: String
    let nextPageToken: String
    let pageInfo: PageInfo
    let items: [Item]
    
    // MARK: - PageInfo
    struct PageInfo: Decodable {
        let totalResults: Int
        let resultsPerPage: Int
    }
    
    // MARK: - item
    struct Item: Decodable {
        let id: String
        let etag: String
        let kind: String
        let snippet: Snippet
        let contentDetails: ContentDetails
        
        // MARK: - Snippet
        struct Snippet: Decodable {
            let publishedAt: String
            let channelId: String
            let title: String
            let description: String
            let channelTitle: String
            let thumbnails: Thumbnails
            let localized: Localized
            
            // MARK: - Thumbnails
            struct Thumbnails: Decodable {
                let medium: Default
                
                // MARK: - ThumbnailsCharacteristics
                struct Default: Decodable {
                    let url: String
                    let width: Int
                    let height: Int
                }
            }
            
            // MARK: - Localized
            struct Localized: Decodable {
                let title: String
                let description: String
            }
        }
        
        // MARK: - ContentDetails
        struct ContentDetails: Decodable {
            let itemCount: Int
        }
    }
}
