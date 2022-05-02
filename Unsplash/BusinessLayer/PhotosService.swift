//
//  PhotosService.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 30.04.2022.
//

import Foundation
import Alamofire


protocol PhotosService {
    func getPhotos(success: @escaping ([Photo]) -> Void, failure: @escaping (Error) -> Void)

    func getCollections(success: @escaping ([Collection]) -> Void, failure: @escaping (Error) -> Void)

    func getCollectionPhotos(id: Int, success: @escaping ([Photo]) -> Void, failure: @escaping (Error) -> Void)

    func getSearchPhotos(searchTerm: String, success: @escaping ([Photo]) -> Void, failure: @escaping (Error) -> Void)
    
    func getSearchCollections(searchTerm: String, success: @escaping ([Collection]) -> Void, failure: @escaping (Error) -> Void)
    
    func getSearchUsers(searchTerm: String, success: @escaping ([User]) -> Void, failure: @escaping (Error) -> Void)
    
    func getListTopics(success: @escaping ([Topic]) -> Void, failure: @escaping (Error) -> Void)
    
    func getTopic(id: String ,success: @escaping (Topic) -> Void, failure: @escaping (Error) -> Void)
    
    func getTopicPhotos(id: String ,success: @escaping ([Photo]) -> Void, failure: @escaping (Error) -> Void)
}

class PhotosServiceImpl: PhotosService {
    let networkClient = NetworkClient()
    
    func getPhotos(success: @escaping ([Photo]) -> Void, failure: @escaping (Error) -> Void) {
        var components = URLComponents()
        components.queryItems = [URLQueryItem(name: "page", value: EndPoint.getPhotosPage)]
        let urlString = String(format: "%@photos", EndPoint.baseUrl)
        guard let url = URL(string: urlString + components.string!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest.allHTTPHeaderFields = prepareHeader()
        networkClient.makeRequest(request: urlRequest, success: success, failure: failure)
    }
    
    func getCollections(success: @escaping ([Collection]) -> Void, failure: @escaping (Error) -> Void) {
        var components = URLComponents()
        components.queryItems = [URLQueryItem(name: "page", value: EndPoint.getPhotosPage)]
        let urlString = String(format: "%@collections", EndPoint.baseUrl)
        guard let url = URL(string: urlString + components.string!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest.allHTTPHeaderFields = prepareHeader()
        networkClient.makeRequest(request: urlRequest, success: success, failure: failure)
    }

    func getCollectionPhotos(id: Int, success: @escaping ([Photo]) -> Void, failure: @escaping (Error) -> Void) {
        var components = URLComponents()
        components.queryItems = [URLQueryItem(name: "page", value: EndPoint.getCollectionPhotosPage),
                                 URLQueryItem(name: "per_page", value: EndPoint.getCollectionPhotosPerPage)]
        let urlString = String(format: "%@collections/\(id)/photos", EndPoint.baseUrl)
        guard let url = URL(string: urlString + components.string!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest.allHTTPHeaderFields = prepareHeader()
        networkClient.makeRequest(request: urlRequest, success: success, failure: failure)
    }

    func getSearchPhotos(searchTerm: String,success: @escaping ([Photo]) -> Void, failure: @escaping (Error) -> Void) {
        var components = URLComponents()
        components.queryItems = [URLQueryItem(name: "page", value: EndPoint.getSearchPhotosPage), URLQueryItem(name: "per_page", value: EndPoint.getListTopicsPerPage), URLQueryItem(name: "query", value: searchTerm)]
        let urlString = String(format: "%@search/photos", EndPoint.baseUrl)
        guard let url = URL(string: urlString + components.string!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest.allHTTPHeaderFields = prepareHeader()
        networkClient.makeRequest(
            request: urlRequest,
            success: { (response: SearchPhotosWrapper) in
                success(response.results)
            },
            failure: failure
        )
    }
    
    func getSearchCollections(searchTerm: String, success: @escaping ([Collection]) -> Void, failure: @escaping (Error) -> Void) {
        var components = URLComponents()
        components.queryItems = [URLQueryItem(name: "page", value: EndPoint.getSearchCollectionsPage), URLQueryItem(name: "query", value: searchTerm)]
        let urlString = String(format: "%@search/collections", EndPoint.baseUrl)
        guard let url = URL(string: urlString + components.string!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest.allHTTPHeaderFields = prepareHeader()
        networkClient.makeRequest(
            request: urlRequest,
            success: { (response: SearchCollectionWrapper) in
                success(response.results)
            },
            failure: failure
        )
    }
    
    func getSearchUsers(searchTerm: String, success: @escaping ([User]) -> Void, failure: @escaping (Error) -> Void) {
        var components = URLComponents()
        components.queryItems = [URLQueryItem(name: "page", value: EndPoint.getSearchUsersPage), URLQueryItem(name: "query", value: searchTerm)]
        let urlString = String(format: "%@search/users", EndPoint.baseUrl)
        guard let url = URL(string: urlString + components.string!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest.allHTTPHeaderFields = prepareHeader()
        networkClient.makeRequest(
            request: urlRequest,
            success: { (response: SearchUsersWrapper) in
                success(response.results)
            },
            failure: failure
        )
    }
    
    
    func getListTopics(success: @escaping ([Topic]) -> Void, failure: @escaping (Error) -> Void) {
        var components = URLComponents()
        components.queryItems = [URLQueryItem(name: "page", value: EndPoint.getListTopicsPage), URLQueryItem(name: "per_page", value: EndPoint.getListTopicsPerPage)]
        let urlString = String(format: "%@topics", EndPoint.baseUrl)
        guard let url = URL(string: urlString + components.string!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest.allHTTPHeaderFields = prepareHeader()
        networkClient.makeRequest(request: urlRequest, success: success, failure: failure)
    }
    
    func getTopic(id: String, success: @escaping (Topic) -> Void, failure: @escaping (Error) -> Void) {
        let urlString = String(format: "%@topics/\(id)", EndPoint.baseUrl)
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest.allHTTPHeaderFields = prepareHeader()
        networkClient.makeRequest(request: urlRequest, success: success, failure: failure)
    }
    
    func getTopicPhotos(id: String,success: @escaping ([Photo]) -> Void, failure: @escaping (Error) -> Void) {
        var components = URLComponents()
        components.queryItems = [URLQueryItem(name: "page", value: EndPoint.getListTopicsPage)]
        let urlString = String(format: "%@topics/\(id)/photos", EndPoint.baseUrl)
        guard let url = URL(string: urlString + components.string!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest.allHTTPHeaderFields = prepareHeader()
        networkClient.makeRequest(request: urlRequest, success: success, failure: failure)
    }
    
    private func prepareHeader() -> [String: String] {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID JC1nPYCRWmEH_GJFPbpUBZC_RE21P-WEz5izlo00ZIo"
        return headers
    }
}
