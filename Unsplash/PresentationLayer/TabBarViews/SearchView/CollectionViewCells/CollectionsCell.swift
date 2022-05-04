//
//  CollectionsCell.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 01.05.2022.
//

import UIKit

class CollectionsCell: UICollectionViewCell {
    
    var data: Collection? {
        didSet {
            guard let data = data else { return }
            if let url = URL(string: data.coverPhoto.urls.small) {
                imageView.downloadImage(from: url)
            }
            title.text = data.title
        }
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = label.font.withSize(26)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        setupConstaraints()
    }
    
    func configure(data: Collection) {
        let urlString = data.coverPhoto.urls.small
        if let url = URL(string: urlString) {
            imageView.downloadImage(from: url)
        }
        title.text = data.title
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
        
        contentView.addSubview(title)
        title.snp.makeConstraints() {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
