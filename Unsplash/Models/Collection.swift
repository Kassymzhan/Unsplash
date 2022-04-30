//
//  Collection.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 30.04.2022.
//

import Foundation

struct Collection: Decodable {
    let id: String
    let title: String
    let coverPhoto: Photo
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case coverPhoto = "cover_photo"
    }
}
