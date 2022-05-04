//
//  HeaderCollectionReusableView.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 04.05.2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderCollectionReusableView"
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    
    func configure() {
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints() {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.top.bottom.equalToSuperview()
        }
    }
}
