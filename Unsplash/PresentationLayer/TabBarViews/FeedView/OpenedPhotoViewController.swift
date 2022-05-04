//
//  OpenedPhotoView.swift
//  Unsplash
//
//  Created by Нурым Нагиметов on 03.05.2022.
//

import UIKit
import SnapKit
class OpenedPhotoViewController: UIViewController {
    var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var imageUrl: String? {
        didSet{
            if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
                imageView.downloadImage(from: url)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.backgroundColor = .black
        setupNavigationBar()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .action)
    }
    
    private func setupConstraints(){
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
