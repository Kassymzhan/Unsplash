//
//  PhotosService.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 30.04.2022.
//

import Foundation
import Alamofire

struct Photo: Decodable {
    let id: String
    let width: Int
    let height: Int
}

protocol PhotosService {
    func getPhotos(page: Int, success: @escaping ([Photo]) -> Void, failure: @escaping (Error) -> Void)
}

class PhotosServiceImpl: PhotosService {
    let networkClient = NetworkClient()
    
    func getPhotos(page: Int, success: @escaping ([Photo]) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = URL(string: "https://api.unsplash.com/photos?page=\(page)") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest.headers = HTTPHeaders([HTTPHeader(name: "Authorization", value: "Client-ID JC1nPYCRWmEH_GJFPbpUBZC_RE21P-WEz5izlo00ZIo")])
        networkClient.makeRequest(request: urlRequest, success: success, failure: failure)
    } 
}
