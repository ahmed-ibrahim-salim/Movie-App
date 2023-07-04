//
//  NotificationModel.swift
//  NewUI-UIKit
//
//  Created by Ahmad medo on 04/07/2023.
//

import Foundation

// MARK: - MoviesModel

struct MoviesModel: Codable {
    let page: Int?
    var results: [Result]?
    let totalPages, totalResults: Int?

}

// MARK: - Result
struct Result: Codable {
    let adult: Bool?
    var backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    var posterPath: String?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
