//
//  UnsplashViewModel.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 02.05.2022.
//

import Foundation

class UnsplashViewModel {
    private let service: PhotosService
    private(set) var photos: [Photo] = []
    private(set) var collections: [Collection] = []
    private(set) var users: [User] = []
    
    var didLoadPhotos: (([Photo]) -> Void)?
    var didGetCollections: (([Collection]) -> Void)?
    var didGetSearchPhotos: (([Photo]) -> Void)?
    var didGetCollectionPhotos: (([Photo]) -> Void)?
    var didGetSearchCollections: (([Collection]) -> Void)?
    var didGetSearchUsers: (([User]) -> Void)?
    var didGetUserPhotos: (([Photo]) -> Void)?
    var didGetUserLikedPhotos: (([Photo]) -> Void)?
    var didGetUserCollections: (([Collection]) -> Void)?
    
    var query: [String] = [""]
    
    init(service: PhotosService) {
        self.service = service
    }
    
    func getPhotos() {
        service.getPhotos(
            success: { [weak self] photos in
                self?.photos = photos
                self?.didLoadPhotos?(photos)
            }, failure: { error in
                print(error)
            }
        )
    }
    
    func getCollections() {
        service.getCollections(
            success: {[weak self] collections in
                self?.collections = collections
                self?.didGetCollections?(collections)
            },
            failure: { error in
                print(error)
            }
        )
    }
    
    func getSearchPhotos(query: String) {
        service.getSearchPhotos(
            searchTerm: query,
            success: {[weak self] photos in
                self?.photos = photos
                self?.didGetSearchPhotos?(photos)
            },
            failure: { error in
                print(error)
            }
        )
    }
    
    func getCollectionPhotos(id: Int) {
        service.getCollectionPhotos(
            id: id,
            success: {[weak self] photos in
                self?.photos = photos
                self?.didGetCollectionPhotos?(photos)
            },
            failure:{ error in
                print(error)
            }
        )
    }
    
    func getSearchCollections(query: String) {
        service.getSearchCollections(
            searchTerm: query,
            success: {[weak self] collections in
                self?.collections = collections
//                print(collections)
                self?.didGetSearchCollections?(collections)
            },
            failure: { error in
                print(error)
            }
        )
    }
    
    func getSearchUsers(query: String) {
        service.getSearchUsers(
            searchTerm: query,
            success: {[weak self] users in
                self?.users = users
                self?.didGetSearchUsers?(users)
            },
            failure: { error in
                print(error)
            }
        )
    }
    
    func getUserPhotos() {
        service.getUserPhotos(
            username: "pangare",
            success: { [weak self] photos in
                self?.photos = photos
                self?.didGetUserPhotos?(photos)
            },
            failure: {error in
                print(error)
            }
        )
    }
    
    func getUserLikedPhotos() {
        service.getUserLikedPhotos(
            username: "pangare",
            success: { [weak self] photos in
                self?.photos = photos
                self?.didGetUserLikedPhotos?(photos)
            },
            failure: {error in
                print(error)
            }
        )
    }

    
    func getUserCollections() {
        service.getUserCollections (
            username: "pangare",
            success: { [weak self] collections in
                self?.collections = collections
                self?.didGetUserCollections?(collections)
            },
            failure: {error in
                print(error)
            }
        )
    }
}
