//
//  ChannelsModel.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import Foundation

// MARK: - ChannelsModel
struct ChannelModel: Codable {
    let kind: String
    let etag: String
    let pageInfo: PageInfo
    let items: [Item]
    
    // MARK: - PageInfo
    struct PageInfo: Codable {
        let totalResults: Int
        let resultsPerPage: Int
    }
    
    // MARK: - Item
    struct Item: Codable {
        let kind: String
        let etag: String
        let id: String
        let snippet: Snippet
        let statistics: Statistics?
        let brandingSettings: BrandingSettings
        
        // MARK: - Snippet
        struct Snippet: Codable {
            let title: String
            let description: String
            let customUrl: String
            let publishedAt: String
            let defaultLanguage: String
            let country: String
            let thumbnails: Thumbnails
            let localized: Localized
            
            // MARK: - Thumbnails
            struct Thumbnails: Codable {
                let defaultSize: Default
                let medium: Default
                let high: Default
                
                enum CodingKeys: String, CodingKey {
                    case defaultSize = "default"
                    case medium
                    case high
                }
                
                // MARK: - Default
                struct Default: Codable {
                    let url: String
                    let width: Int
                    let height: Int
                }
            }
            
            // MARK: - Localized
            struct Localized: Codable {
                let title: String
                let description: String
            }
        }
        
        // MARK: - Statistics
        struct Statistics: Codable {
            let viewCount: String
            let subscriberCount: String
            let videoCount: String
            let hiddenSubscriberCount: Bool
        }
        
        // MARK: - BrandingSettings
        struct BrandingSettings: Codable {
            let channel: Channel
            let image: Image
        }
        
        // MARK: - Channel
        struct Channel: Codable {
            let title: String
            let description: String
            let keywords: String
            let defaultLanguage: String
            let country: String
        }
        
        // MARK: - Image
        struct Image: Codable {
            let bannerExternalUrl: String
        }
    }
}
