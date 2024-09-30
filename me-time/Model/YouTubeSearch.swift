//
//  YouTubeSearch.swift
//  me-time
//
//  Created by junehee on 9/30/24.
//

import Foundation

struct YouTubeSearch: Decodable {
    let kind: String
    let etag: String
    let nextPageToken: String
    let regionCode: String
    let items: [YouTubeSearchItems]
}

struct YouTubeSearchItems: Decodable {
    let kind: String
    let etag: String
    let id: YouTubeSearchItemId
    let snippet: YouTubeSearchItemSnippet
}

struct YouTubeSearchItemId: Decodable {
    let kind: String
    let videoId: String
}

struct YouTubeSearchItemSnippet: Decodable {
    let publishedAt: String
    let publishTime: String
    let channelId: String
    let channelTitle: String
    let title: String
    let description: String
    let thumbnails: YouTubeSearchItemThumbnails
}

struct YouTubeSearchItemThumbnails: Decodable {
    let medium: Thumbnail
    let high: Thumbnail
}

struct Thumbnail: Decodable {
    let url: String
    let width: Int
    let height: Int
}
