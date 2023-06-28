//
//  CastModel.swift
//  MovieTime
//
//  Created by Eken Özlü on 25.06.2023.
//

import Foundation

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?
    let department: String?
    let job: String?
    
    //For persons' acted/participated in
    let posterPath: String?
    let title: String?
    let mediaType: MediaType?
    let firstAirDate, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
        //For persons' acted/participated in
        case posterPath = "poster_path"
        case title
        case mediaType = "media_type"
        case firstAirDate = "first_air_date"
        case releaseDate = "release_date"
    }
}
