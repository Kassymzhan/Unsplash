//
//  PhotoCell.swift
//  Unsplash
//
//  Created by Нурым Нагиметов on 01.05.2022.
//

import UIKit
typealias PhotoCellConfigurator = TableCellConfigurator<PhotoCell, Photo>
class PhotoCell: UITableViewCell, ConfigurableCell {
    
    typealias DataType = Photo
    
    let image: UIImageView = {
        let image = UIImageView()
        return image
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Photo) {
        image.image = UIImage(named: data.urls.raw)
    }
    
    private func setupConstaraints() {
        image.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    

}
