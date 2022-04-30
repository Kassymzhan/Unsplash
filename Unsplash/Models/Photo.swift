//
//  Photo.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 30.04.2022.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let width: Int
    let height: Int
    let color: String
    let description: String?
    let createdAt: String
    let urls: Urls
    
    enum CodingKeys: String, CodingKey {
        case id
        case width, height, color
        case description
        case createdAt = "created_at"
        case urls = "urls"
    }
}
