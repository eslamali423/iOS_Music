//
//  APIResponse.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import Foundation

// MARK: - Welcome
struct APIResponse: Codable {
    let feed: Feed
}

// MARK: - Feed
struct Feed: Codable {
    let title: String
    let results: [Results]
}


// MARK: - Result
struct Results: Codable {
    let artistName, id, name, releaseDate: String
    let kind: String
    let artistUrl: String?
    let artworkUrl100: String
    let url: String

}



