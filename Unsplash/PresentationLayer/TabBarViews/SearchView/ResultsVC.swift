//
//  ResultsVC.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 02.05.2022.
//

import UIKit

class ResultsVC: UIViewController {
    private let viewModel: UnsplashViewModel
    
    init(viewModel: UnsplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let searchSubjectSegmentedControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        let values = ["Photos", "Collections", "Users"]
        values.forEach{ value in
            segmentControl.insertSegment(withTitle: value, at: segmentControl.numberOfSegments, animated: true)
        }
        segmentControl.selectedSegmentIndex = 0
        segmentControl.tintColor = .label
        segmentControl.addTarget(self, action: #selector(didChangeSegment(sender:)), for: .valueChanged)
        return segmentControl
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        searchSubjectConfigure()
        buildCells()
    }
    
//    private var items: [Discover] = []
//
//    let PhotoSearchCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 1
//        layout.minimumInteritemSpacing = 1
//        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
//
//    private func buildCells() {
//        let photos = viewModel.photos.map { photo in
//            PhotoPO(id: photo.id, width: photo.width, height: photo.height, color: photo.color, description: photo.description, createdAt: photo.createdAt, urls: photo.urls.small, user: photo.user)
//        }
//        for photo in photos {
//            let config = Discover(imageUrl: photo.urls, name: photo.user.name, height: photo.height)
//            items.append(config)
//        }
//        PhotoSearchCollectionView.reloadData()
//    }
//
//    private func bindViewModel() {
//        viewModel.didGetSearchPhotos = {[weak self] _ in
//            self?.buildCells()
//        }
//    }
    private var items: [Discover] = []
    
    let PhotoSearchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func buildCells() {
        let photos = viewModel.photos.map { photo in
            PhotoPO(id: photo.id, width: photo.width, height: photo.height, color: photo.color, description: photo.description, createdAt: photo.createdAt, urls: photo.urls.small, user: photo.user)
        }
        for photo in photos {
            let config = Discover(imageUrl: photo.urls, name: photo.user.name, height: photo.height)
            items.append(config)
        }
        PhotoSearchCollectionView.reloadData()
    }
    
    @objc func didChangeSegment(sender: UISegmentedControl) {
        switch searchSubjectSegmentedControl.selectedSegmentIndex {
        case 0: print()
        case 1: print("Collections")
        case 2: print("Users")
        default: break
        }
    }
    
    private func searchSubjectConfigure() {
        view.addSubview(searchSubjectSegmentedControl)
        searchSubjectSegmentedControl.snp.makeConstraints() {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
    }
}

extension ResultsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = items[indexPath.startIndex]
        return CGSize(width: (collectionView.frame.width / 2) - 1, height: CGFloat(photo.height/16))
    }
}

extension ResultsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DiscoverCell
        cell.data = self.items[indexPath.row]
        return cell
    }
}
