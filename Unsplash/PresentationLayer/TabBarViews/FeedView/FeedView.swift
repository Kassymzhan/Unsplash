//
//  FeedView.swift
//  Unsplash
//
//  Created by Нурым Нагиметов on 30.04.2022.
//

import UIKit
import SnapKit

class FeedView: UIViewController {
//    let service = PhotosServiceImpl()
    private let viewModel: UnsplashViewModel
   
    private let items: [CellConfigurator] = []
    
    init(viewModel: UnsplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableDirector: TableDirector = {
        let tableDirector = TableDirector(tableView: tableView, items: items)
        return tableDirector
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private func bindViewModel() {
        viewModel.didLoadPhotos = { [weak self] _ in
            self?.buildCells()
        }
    }
    
    private func buildCells() {
        let photos = viewModel.photos.map { photo in
            PhotoPO(id: photo.id, width: photo.width, height: photo.height, color: photo.color, description: photo.description, createdAt: photo.createdAt, urls: photo.urls.regular, user: photo.user)
        }
        var cellConfigurators: [PhotoCellConfigurator] = []
        for photo in photos {
            let config = PhotoCellConfigurator(item: photo)
            cellConfigurators.append(config)
        }
        tableDirector.items = cellConfigurators
        tableDirector.tableView.reloadData()
    }
    
    private func fetchData() {
        viewModel.getPhotos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        constraintTableView()
        bindViewModel()
        tableDirector.tableView.reloadData()
    }
    
    private func constraintTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        tableView.backgroundColor = .secondarySystemBackground
    }
}

