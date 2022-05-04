//
//  DiscoverCell.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 01.05.2022.
//

import UIKit

class DiscoverCell: UICollectionViewCell {
    
    var data: Photo? {
        didSet {
            guard let data = data else { return }
            if let url = URL(string: data.urls.small) {
                imageView.downloadImage(from: url)
            }
            name.text = data.user.name
        }
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
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
        if let url = URL(string: urlString) {
            imageView.downloadImage(from: url)
        }
        name.text = data.user.instagramUsername
    }
    
    private func setupConstaraints() {
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints() {
            $0.center.equalToSuperview()
            $0.width.equalTo(contentView.snp.width)
            $0.height.equalTo(contentView.snp.height)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        contentView.addSubview(name)
        name.snp.makeConstraints() {
            $0.leading.equalTo(imageView.snp.leading).inset(4)
            $0.bottom.equalTo(imageView.snp.bottom).inset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
