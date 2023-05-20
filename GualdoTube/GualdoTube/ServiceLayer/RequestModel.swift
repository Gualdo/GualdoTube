//
//  RequestModel.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import Foundation

struct RequestModel {
    let endpoint: Endpoints
    let httpMethod: HttpMethod = .GET
    var queryItems: [String: String]?
    var baseUrl: URLBase = .youtube
    
    enum HttpMethod: String {
        case GET
        case POST
    }
    
    enum Endpoints: String {
        case search = "/search"
        case channles = "/channels"
        case playlist = "/playlist"
        case playlistItems = "/playlistItems"
        case videos = "/videos"
        case empty = ""
    }
    
    enum URLBase: String {
        case youtube = "https://youtube.googleapis.com/youtube/v3"
        case google = "https://othereweb.com/v2"
    }
    
    func getURL() -> String {
        return baseUrl.rawValue + endpoint.rawValue
    }
}
