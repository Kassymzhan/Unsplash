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
    
    var didLoadPhotos: (([Photo]) -> Void)?
    var didGetCollections: (([Collection]) -> Void)?
    var didGetSearchPhotos: (([Photo]) -> Void)?
    var didGetCollectionPhotos: (([Photo]) -> Void)?
    
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
}
