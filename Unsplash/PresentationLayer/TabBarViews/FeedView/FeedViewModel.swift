//
//  FeedViewModel.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 01.05.2022.
//

import Foundation

class FeedViewModel {
    private let service: PhotosService
    private(set) var photos: [Photo] = []
    
    var didLoadPhotos: (([Photo]) -> Void)?
    
    init(service: PhotosService) {
        self.service = service
    }
    
    func getPhotos() {
        service.getPhotos(
            success: { [weak self] photos in
                self?.photos = photos
                self?.didLoadPhotos?(photos)
            }, failure: { [weak self] error in
                print(error)
            }
        )
    }
}
