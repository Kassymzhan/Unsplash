//
//  DiscoverCell.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 01.05.2022.
//

import UIKit

class DiscoverCell: UICollectionViewCell {
    
    var data: Discover? {
        didSet {
            guard let data = data else { return }
            downloadImage(from: URL(string: data.imageUrl)!, newsImage: image)
            name.text = data.name
        }
    }
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didTapCell)))
        return image
    }()
    
    @objc func didTapCell() {
        print("123")
    }
    
    let name: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = label.font.withSize(13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        setupConstaraints()
    }
    
    func configure(data: PhotoPO) {
        let urlString = data.urls
        let url = URL(string: urlString)
        downloadImage(from: url!, newsImage: image)
        name.text = data.user.instagramUsername
    }
    
    private func setupConstaraints() {
        
        contentView.addSubview(image)
        image.snp.makeConstraints() {
            $0.center.equalToSuperview()
            $0.width.equalTo(contentView.snp.width)
            $0.height.equalTo(contentView.snp.height)
        }
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        contentView.addSubview(name)
        name.snp.makeConstraints() {
            $0.leading.equalTo(image.snp.leading).inset(4)
            $0.bottom.equalTo(image.snp.bottom).inset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionViewCell {
    func downloadImage(from url: URL, newsImage: UIImageView) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                newsImage.image = UIImage(data: data)
            }
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
