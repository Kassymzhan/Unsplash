//
//  UITableViewCell+DowloadImage.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 03.05.2022.
//

import UIKit

// MARK: - UITableViewCell + DownloadImage
extension UITableViewCell {
    func setImagetoButton(from url: URL, button: UIButton) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async { [weak self] in
                button.setImage(UIImage(data: data), for: .normal)

            }
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
