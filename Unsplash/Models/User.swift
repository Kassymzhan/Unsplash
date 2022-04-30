//
//  User.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 30.04.2022.
//

import Foundation

struct User: Decodable {
    let id: String
    let username: String
    let name: String
    let firstName: String
    let secondName: String?
    let instagramUsername: String?
    let totalLikes: Int
    let totalPhotos: Int
    let totalCollections: Int
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case id, username, name
        case firstName = "first_name"
        case secondName, instagramUsername
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
        case profileImage = "profile_image"
    }
}
