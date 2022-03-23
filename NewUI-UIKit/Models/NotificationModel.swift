//
//  NotificationModel.swift
//  NewUI-UIKit
//
//  Created by ahmadibrahim on 12/9/21.
//

//import Foundation

import Foundation

//// MARK: - NotificationModel
//struct NotificationModel: Codable {
//    let status: Bool?
//    let message: String?
//    let data: [Notification]?
//    let count: Int?
//}
//
//// MARK: - Notification
//struct Notification: Codable {
//    let id: Int?
//       let title: String?
//       let body: String?
//       let read: Int?
//       let date: String?
//}
//
//// MARK: - generalResponceModel
//struct generalResponceModel: Codable {
//    let status: Bool?
//    let message: String?
//}


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
