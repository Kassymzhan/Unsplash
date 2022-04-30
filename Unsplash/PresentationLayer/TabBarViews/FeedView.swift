//
//  FeedView.swift
//  Unsplash
//
//  Created by Нурым Нагиметов on 30.04.2022.
//

import UIKit
import SnapKit
class FeedView: UIViewController {
    let service = PhotosServiceImpl()
    private let photos: [CellConfigurator] = [PhotoCellConfigurator(item: Photo(from: ))]
   
    

    
    let tableView : UITableView = {
        let table = UITableView()
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    private func constraintTableView() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

extension FeedView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell
    }
}
extension FeedView: UITableViewDelegate {
    
}
