//
//  ProfileImage.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 30.04.2022.
//

import Foundation

struct ProfileImage: Decodable {
    let small, medium, large: String
    
    enum CodingKeys: String, CodingKey {
        case small, medium, large
    }
}
