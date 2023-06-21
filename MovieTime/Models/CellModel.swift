//
//  MovieModel.swift
//  MovieTime
//
//  Created by Eken Özlü on 15.06.2023.
//

import Foundation

// MARK: - MovieModel
struct CellModel: Codable {
    let page: Int?
    let results: [CellResult]?
    let totalPages, totalResults: Int?
    let dates: Dates?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case dates
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - Result
struct CellResult: Codable {
    let id: Int?
    let title, originalTitle: String?
    let name, originalName: String?
    let posterPath: String?
    let profilePath: String?
    let mediaType: MediaType?
    let popularity: Double?
    let releaseDate: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id, title
        case originalTitle = "original_title"
        case name
        case originalName = "original_name"
        case posterPath = "poster_path"
        case profilePath = "profile_path"
        case mediaType = "media_type"
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case person = "person"
    case tv = "tv"
}
