//
//  ViewController.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 29.04.2022.
//

import UIKit

class ViewController: UIViewController {
    let service = PhotosServiceImpl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        service.getPhotos(
            page: 2,
            success: { photos in
                print(photos)
            }, failure: { error in
                print(error)
            }
        )
    }
}
