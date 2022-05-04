//
//  UserDetailsViewController.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 04.05.2022.
//

import UIKit

class UserDetailsViewController: UIViewController {
    var userName: String?
    
    let IdLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(IdLabel)
        IdLabel.text = userName
        IdLabel.snp.makeConstraints() {
            $0.center.equalToSuperview()
        }
    }
}
