//
//  CollectionsCell.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 01.05.2022.
//

import UIKit

class CollectionsCell: UICollectionViewCell {
    
    var data: CollectionPO? {
        didSet {
            guard let data = data else { return }
            downloadImage(from: URL(string: data.collectionPhoto.urls.small)!, newsImage: image)
            title.text = data.title
        }
    }
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        return image
    }()
    
    let title: UILabel = {
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
    
    func configure(data: CollectionPO) {
        let urlString = data.collectionPhoto.urls.small
        let url = URL(string: urlString)
        downloadImage(from: url!, newsImage: image)
        title.text = data.title
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
        
        contentView.addSubview(title)
        title.snp.makeConstraints() {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
