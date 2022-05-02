//
//  ResultsVC.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 02.05.2022.
//

import UIKit

class ResultsVC: UIViewController {
    private let viewModel: UnsplashViewModel
    
    private var items: [Discover] = []
    
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
        segmentControl.tintColor = .label
        segmentControl.addTarget(self, action: #selector(didChangeSegment(sender:)), for: .allEvents)
        return segmentControl
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        buildCells()
        searchSubjectConfigure()
        bindViewModel()
        collectionViewSetUp()
    }
    
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
    
    
    func fetchPhotoData(query: String) {
        viewModel.getSearchPhotos(query: query)
    }
    
    func fetchCategoriesData(query: String) {
        viewModel.getSearchCollections(query: query)
    }
    
    func fetchUsersData(query: String) {
        viewModel.getSearchUsers(query: query)
    }
    
    
    private func bindViewModel() {
        viewModel.didLoadPhotos = { [weak self] _ in
            self?.buildCells()
        }
        viewModel.didGetSearchPhotos = {[weak self] _ in
            self?.buildCells()
        }
        viewModel.didGetCollectionPhotos = {[weak self] _ in
            self?.buildCells()
        }
        viewModel.didGetSearchCollections = {[weak self] _ in
            self?.buildCells()
        }
        viewModel.didGetSearchUsers = {[weak self] _ in
            self?.buildCells()
        }
    }
    
    @objc func didChangeSegment(sender: UISegmentedControl) {
        switch searchSubjectSegmentedControl.selectedSegmentIndex {
        case 0:
            PhotoSearchCollectionView.reloadData()
            fetchPhotoData(query: QueryString.instance.query)
        case 1: print("Collections")
        case 2: print("Users")
        default: break
        }
    }
    
    private func collectionViewSetUp(){
        view.addSubview(PhotoSearchCollectionView)
        PhotoSearchCollectionView.delegate = self
        PhotoSearchCollectionView.dataSource = self
        PhotoSearchCollectionView.snp.makeConstraints() {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(64)
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
// MARK: - UICollectionViewDelegateFlowLayout
extension ResultsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = items[indexPath.startIndex]
        return CGSize(width: (collectionView.frame.width / 2) - 1, height: CGFloat(photo.height/16))
    }
}

// MARK: - UICollectionViewDataSource
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
