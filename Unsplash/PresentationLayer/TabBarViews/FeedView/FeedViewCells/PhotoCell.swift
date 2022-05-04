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
    
    static let didTapButtonAction = "PhotoCellDidTapButtonAction"
    
    private lazy var frameWidth = self.layer.frame.width
    
    let image: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupConstaraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton() {
        CellAction.custom(type(of: self).didTapButtonAction).invoke(cell: self)
    }
    
    func configure(data: PhotoPO) {
        let urlString = data.urls
        label.text = "\(data.user.firstName) \(data.user.secondName ?? "")"
//        setImagetoButton(from: url!, button: button)
//        downloadImage(from: url!, newsImage: image)
        if let url = URL(string: urlString) {
            image.downloadImage(from: url)
            button.imageView?.downloadImage(from: url)
            setImagetoButton(from: url, button: button)
        }
        let multiplier = data.width / Int(frameWidth)
        
        button.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.height.equalTo(data.height / multiplier)
        }
    }
    
    private func setupConstaraints() {
        contentView.addSubview(button)
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}
