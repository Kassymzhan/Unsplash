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
        let vc1 = UINavigationController(rootViewController: FeedView(viewModel: UnsplashViewModel(service: PhotosServiceImpl())))
        let vc2 = UINavigationController(rootViewController: SearchViewController(viewModel: UnsplashViewModel(service: PhotosServiceImpl())))
        let vc3 = AddView()
        let vc4 = ProfileView()
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
        
        self.tabBar.backgroundColor = .systemBackground
        self.modalPresentationStyle = .fullScreen
        self.tabBar.tintColor = .label
        guard let items = self.tabBar.items else {return}
        let image = ["photo.fill", "magnifyingglass", "plus.app.fill", "person.circle.fill"]
        for i in 0...items.count - 1 {
            items[i].image = UIImage(systemName: image[i])
        }
        view.backgroundColor = .black

    }
}
