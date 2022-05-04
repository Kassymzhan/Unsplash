//
//  OpenedCollectionViewController.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 04.05.2022.
//

import UIKit

class OpenedCollectionViewController: UIViewController {
    private let viewModel: UnsplashViewModel
    
    var collectionId: String?
    
    init(viewModel: UnsplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        bindViewModel()
        buildCells()
        collectionPhotoCollectionViewSetUp()
    }
    
    private func collectionPhotoCollectionViewSetUp() {
        view.addSubview(collectionPhotosCollectionView)
        collectionPhotosCollectionView.delegate = self
        collectionPhotosCollectionView.dataSource = self
        collectionPhotosCollectionView.snp.makeConstraints() {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
    }

    private let collectionPhotosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private func buildCells() {
        collectionPhotosCollectionView.reloadData()
    }
    
    private func fetchData() {
        guard let collectionId = Int(collectionId!) else { return }
        viewModel.getCollectionPhotos(id: collectionId)
    }
    
    private func bindViewModel() {
        viewModel.didGetCollectionPhotos = {[weak self] _ in
            self?.buildCells()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OpenedCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = viewModel.photos[indexPath.startIndex]
        return CGSize(width: (collectionView.frame.width / 2) - 1, height: CGFloat(photo.height/16))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = OpenedPhotoViewController()
        vc.imageUrl = viewModel.photos[indexPath.row].urls.full
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension OpenedCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DiscoverCell
        cell.data = viewModel.photos[indexPath.row]
        return cell
    }
}
