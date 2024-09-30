//
//  YouTubeSearch.swift
//  me-time
//
//  Created by junehee on 9/30/24.
//

import Foundation

struct YouTubeSearch: Decodable, Hashable {
    let kind: String
    let etag: String
    let nextPageToken: String
    let regionCode: String
    let items: [YouTubeSearchItems]
}

struct YouTubeSearchItems: Decodable, Hashable {
    let kind: String
    let etag: String
    let id: YouTubeSearchItemId
    let snippet: YouTubeSearchItemSnippet
}

struct YouTubeSearchItemId: Decodable, Hashable {
    let kind: String
    let videoId: String
}

struct YouTubeSearchItemSnippet: Decodable, Hashable {
    let publishedAt: String
    let publishTime: String
    let channelId: String
    let channelTitle: String
    let title: String
    let description: String
    let thumbnails: YouTubeSearchItemThumbnails
}

struct YouTubeSearchItemThumbnails: Decodable, Hashable {
    let medium: Thumbnail
    let high: Thumbnail
}

struct Thumbnail: Decodable, Hashable {
    let url: String
    let width: Int
    let height: Int
}
