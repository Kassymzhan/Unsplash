//
//  PhotoCell.swift
//  Unsplash
//
//  Created by Нурым Нагиметов on 01.05.2022.
//

import UIKit

struct PhotoPO {
    let id: String
    let width: Int
    let height: Int
    let color: String
    let description: String?
    let createdAt: String
    let urls: String
    let user: User
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(width)
        hasher.combine(height)
        hasher.combine(color)
        hasher.combine(description)
        hasher.combine(createdAt)
        hasher.combine(urls)
//        hasher.combine(user)
    }
}

struct UrlsPO: Hashable {
    let raw, full, regular, small: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(raw)
        hasher.combine(full)
        hasher.combine(regular)
        hasher.combine(small)
    }
}

typealias PhotoCellConfigurator = TableCellConfigurator<PhotoCell, PhotoPO>

class PhotoCell: UITableViewCell, ConfigurableCell {
    
    typealias DataType = PhotoPO
    
    let image: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupConstaraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: PhotoPO) {
        let urlString = data.urls
        let url = URL(string: urlString)
        downloadImage(from: url!, newsImage: image)
    }
    
    private func setupConstaraints() {
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

extension UITableViewCell {
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
