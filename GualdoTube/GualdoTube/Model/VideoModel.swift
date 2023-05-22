//
//  VideoModel.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 19/5/23.
//

import Foundation

// MARK: - VideoModel
struct VideoModel: Decodable {
    let kind: String
    let etag: String
    let items: [Item]
    let pageInfo: PageInfo
    
    // MARK: - Item
    struct Item: Decodable {
        let kind: String
        let id: String?
        let snippet: Snippet?
        let contentDetails: ContentDetails?
        let statistics: Statistics?
        
        enum CodingKeys: String, CodingKey {
            case kind
            case id
            case snippet
            case contentDetails
            case statistics
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.kind = try container.decode(String.self, forKey: .kind)
            
            if let id = try? container.decode(VideoId.self, forKey: .id) {
                self.id = id.videoId
            } else {
                self.id = try container.decodeIfPresent(String.self, forKey: .id)
            }
            
            self.snippet = try container.decodeIfPresent(Snippet.self, forKey: .snippet)
            self.contentDetails = try container.decodeIfPresent(ContentDetails.self, forKey: .contentDetails)
            self.statistics = try container.decodeIfPresent(Statistics.self, forKey: .statistics)
        }
        
        // MARK: - VideoId
        struct VideoId: Decodable {
            let kind: String
            let videoId: String
        }
        
        // MARK: - Snippet
        struct Snippet: Codable {
            let publishedAt: String
            let channelId: String
            let title: String
            let description: String
            let channelTitle: String
            let tags: [String]?
            let thumbnails: Thumbnails
            
            // MARK: - Thumbnails
            struct Thumbnails: Codable {
                let medium: Default?
                let high: Default?
                
                // MARK: - Default
                struct Default: Codable {
                    let url: String
                    let width: Int
                    let height: Int
                }
            }
        }
        
        // MARK: - ContentDetails
        struct ContentDetails: Decodable {
            let duration: String
            let dimension: String
            let definition: String
            let caption: String
            let licensedContent: Bool
            let projection: String
        }
        
        // MARK: - Statistics
        struct Statistics: Codable {
            let viewCount: String
            let likeCount: String
            let favoriteCount: String
            let commentCount: String
        }
    }
    
    // MARK: - PageInfo
    struct PageInfo: Codable {
        let totalResults: Int
        let resultsPerPage: Int
    }
}
