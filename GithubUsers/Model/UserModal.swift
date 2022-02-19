//
//  UserData.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 06/02/22.
//

import Foundation
import UIKit

struct UserModal: Codable {
    var name : String?
    var userImgURL: String?
    var userName : String?
    var bio : String?
    var repoCount: Int?
    var stars: String?
    var followers: Int?
    var followings: Int?
    var imgData: Data?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case userImgURL = "avatar_url"
        case userName = "login"
        case bio = "bio"
        case repoCount = "public_repos"
        case stars = "starred_url"
        case followers = "followers"
        case followings = "following"
    }
}

struct RepoModal: Codable{
    var name: String?
    var visibility: String?
    var description: String?
    var language: String?
    var forks: Int?
    var stargazers_count: Int?
    var updated_at: String?
    var topics: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case visibility = "visibility"
        case description = "description"
        case language = "language"
        case forks = "forks"
        case stargazers_count = "stargazers_count"
        case updated_at = "updated_at"
        case topics = "topics"
    }
}

struct ContributorModal: Codable{
    var name: String?
    var avatar_url: String?
    var contributions: Int?
    var imgData: Data?
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar_url = "avatar_url"
        case contributions = "contributions"
    }
}
