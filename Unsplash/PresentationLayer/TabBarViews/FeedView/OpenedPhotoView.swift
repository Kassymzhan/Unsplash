//
//  OpenedPhotoView.swift
//  Unsplash
//
//  Created by Нурым Нагиметов on 03.05.2022.
//

import UIKit
import SnapKit
class OpenedPhotoView: UIViewController {
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigationBar()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .action)
    }
    
    private func setupConstraints(){
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
