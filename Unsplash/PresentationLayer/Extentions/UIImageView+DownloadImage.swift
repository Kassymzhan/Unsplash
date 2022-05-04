//
//  UITableViewCell+Download.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 02.05.2022.
//

import UIKit

// MARK: - UIImageView + DownloadImage
extension UIImageView {
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
