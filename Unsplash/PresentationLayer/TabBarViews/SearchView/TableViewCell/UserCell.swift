//
//  UserCell.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 04.05.2022.
//

import UIKit

struct UserPO {
    let id: String
    let username: String
    let name: String
    let firstName: String
    let secondName: String?
    let instagramUsername: String?
    let totalLikes: Int
    let totalPhotos: Int
    let totalCollections: Int
    let profileImage: ProfileImage
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(firstName)
        hasher.combine(secondName)
        hasher.combine(instagramUsername)
        hasher.combine(totalLikes)
        hasher.combine(totalPhotos)
        hasher.combine(totalCollections)
        hasher.combine(profileImage)
    }
}


typealias UserCellConfigurator = TableCellConfigurator<UserCell, UserPO>

class UserCell: UITableViewCell, ConfigurableCell {
    
    static let didTapButtonAction = "UserCellDidTapButtonAction"
    
    private let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = label.font.withSize(13)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .secondarySystemBackground
        layoutUI()
    }
    
    func configure(data: UserPO) {
        let urlString = data.profileImage.medium
        if let url = URL(string: urlString) {
            profilePictureImageView.downloadImage(from: url)
        }
        nameLabel.text = data.name
        usernameLabel.text = data.username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        contentView.addSubview(profilePictureImageView)
        profilePictureImageView.snp.makeConstraints() {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.width.equalTo(64)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints() {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(profilePictureImageView.snp.trailing).inset(-16)
            $0.height.equalTo(50)
        }
        
        contentView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints(){
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(profilePictureImageView.snp.trailing).inset(-16)
            $0.bottom.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func layoutSubviews() {
        profilePictureImageView.layer.cornerRadius = 32
        profilePictureImageView.layer.masksToBounds = true
    }
}
