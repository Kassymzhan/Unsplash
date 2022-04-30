//
//  ViewController.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 29.04.2022.
//

import UIKit

class ViewController: UITabBarController {
    let service = PhotosServiceImpl()
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = FeedView()
        let vc2 = SearchView()
        let vc3 = AddView()
        let vc4 = ProfileView()
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
        
        self.tabBar.backgroundColor = .systemGray2
        self.modalPresentationStyle = .fullScreen
        
        guard let items = self.tabBar.items else {return}
        let image = ["text.below.photo.fill", "person.2.fill", "pin.fill", "rectangle.stack.person.crop.fill"]
        for i in 0...items.count - 1 {
            items[i].image = UIImage(systemName: image[i])
        }
        view.backgroundColor = .white
        
        service.getPhotos(
        success: { photos in
            print(photos)
        }, failure: { error in
            print(error)
        })
    }
}
