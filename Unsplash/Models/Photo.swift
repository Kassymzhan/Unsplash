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
    let urls: Urls
}
