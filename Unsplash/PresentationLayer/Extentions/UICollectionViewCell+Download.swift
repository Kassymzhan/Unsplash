//
//  UICollectionViewCell+Download.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 02.05.2022.
//

import UIKit

// MARK: - UICollectionViewCell + Download
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
