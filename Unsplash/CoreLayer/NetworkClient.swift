//
//  NetworkClient.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 30.04.2022.
//

import Alamofire

class NetworkClient {
    func makeRequest<T: Decodable>(request: URLRequest, success: @escaping (T) -> Void, failure: @escaping (AFError) -> Void) {
        let url: Alamofire.URLRequestConvertible = request
        AF.request(url).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let result):
                success(result)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
