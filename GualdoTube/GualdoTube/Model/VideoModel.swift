//
//  VideoModel.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 19/5/23.
//

import Foundation

// MARK: - VideoModel
struct VideoModel: Codable {
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
        let contentDetails: ContentDetails
        let status: Status
        let statistics: Statistics
        let player: Player
        let topicDetails: TopicDetails
        let recordingDetails: RecordingDetails
        
        // MARK: - Snippet
        struct Snippet: Codable {
            let publishedAt: Date
            let channelId: String
            let title: String
            let description: String
            let channelTitle: String
            let categoryId: String
            let liveBroadcastContent: String
            let defaultAudioLanguage: String
            let tags: [String]
            let thumbnails: Thumbnails
            let localized: Localized
            
            // MARK: - Thumbnails
            struct Thumbnails: Codable {
                let ´default´: Default
                let medium: Default
                let high: Default
                let standard: Default
                let maxres: Default
                
                // MARK: - Default
                struct Default: Codable {
                    let url: String
                    let width: Int
                    let height: Int
                }
            }
            
            // MARK: - Localized
            struct Localized: Codable {
                let title, description: String
            }
        }
        
        // MARK: - ContentDetails
        struct ContentDetails: Codable {
            let duration: String
            let dimension: String
            let definition: String
            let caption: String
            let licensedContent: Bool
            let projection: String
            let contentRating: RecordingDetails
        }
        
        // MARK: - Status
        struct Status: Codable {
            let uploadStatus: String
            let privacyStatus: String
            let license: String
            let embeddable: Bool
            let publicStatsViewable: Bool
            let madeForKids: Bool
        }
        
        // MARK: - Statistics
        struct Statistics: Codable {
            let viewCount: String
            let likeCount: String
            let favoriteCount: String
            let commentCount: String
        }
        
        // MARK: - Player
        struct Player: Codable {
            let embedHtml: String
        }
        
        // MARK: - TopicDetails
        struct TopicDetails: Codable {
            let topicCategories: [String]
        }
        
        // MARK: - RecordingDetails
        struct RecordingDetails: Codable {
        }
    }
    
    // MARK: - PageInfo
    struct PageInfo: Codable {
        let totalResults: Int
        let resultsPerPage: Int
    }
}
