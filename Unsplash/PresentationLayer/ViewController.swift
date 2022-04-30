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
        
        self.tabBar.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
        self.modalPresentationStyle = .fullScreen
        self.tabBar.tintColor = .white
        guard let items = self.tabBar.items else {return}
        let image = ["photo.fill", "magnifyingglass", "plus.app.fill", "person.circle.fill"]
        for i in 0...items.count - 1 {
            items[i].image = UIImage(systemName: image[i])
        }
        view.backgroundColor = .black
        
        service.getPhotos(
        success: { photos in
            print(photos[0].urls)
            print(type(of: photos[0].urls.raw))
            
        }, failure: { error in
            print(error)
        })
    }
}
