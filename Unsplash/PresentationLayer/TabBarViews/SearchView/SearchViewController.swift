//
//  SearchView.swift
//  Unsplash
//
//  Created by Нурым Нагиметов on 30.04.2022.
//

import UIKit

class SearchViewController: UIViewController {
    private let viewModel: UnsplashViewModel
    
    private lazy var resultsViewController: ResultsViewController = {
        let vc = ResultsViewController(viewModel: UnsplashViewModel(service: PhotosServiceImpl()))
        vc.delegate = self
        return vc
    }()
    
    init(viewModel: UnsplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: UINavigationController(rootViewController: resultsViewController))
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search photos, collections, users",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        return searchController
    }()

    private let discoverCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationController?.navigationBar.backgroundColor = .black
        fetchData()
        buildCells()
        collectionViewSetUp()
        bindViewModel()
    }
    
    private func fetchData() {
        viewModel.getCollectionPhotos(id: 1599413)
    }

    private func bindViewModel() {
        viewModel.didLoadPhotos = { [weak self] _ in
            self?.buildCells()
        }
        viewModel.didGetCollectionPhotos = {[weak self] _ in
            self?.buildCells()            
        }
    }

    private func buildCells() {
        discoverCollectionView.reloadData()
    }

    private func collectionViewSetUp() {
        view.addSubview(discoverCollectionView)
        discoverCollectionView.dataSource = self
        discoverCollectionView.delegate = self
        discoverCollectionView.snp.makeConstraints(){
            $0.leading.trailing.bottom.top.equalTo(view.safeAreaLayoutGuide)
        }
        discoverCollectionView.backgroundColor = .systemBackground
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = viewModel.photos[indexPath.startIndex]
        return CGSize(width: (collectionView.frame.width / 2) - 1, height: CGFloat(photo.height/20))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = OpenedPhotoViewController()
        vc.imageUrl = viewModel.photos[indexPath.row].urls.full
        navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DiscoverCell
        cell.data = viewModel.photos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        header.configure()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 80)
    }
}
// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resultsViewController.searchText = searchBar.text
    }
}

extension SearchViewController: ResultsViewControllerDelegate {
    func showOpenedCollectionsViewController(collection: Collection) {
        let vc = OpenedCollectionViewController(viewModel: UnsplashViewModel(service: PhotosServiceImpl()))
        vc.collectionId = collection.id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showOpenedPhotoViewController(photo: Photo) {
        let vc = OpenedPhotoViewController()
        vc.imageUrl = photo.urls.regular
        navigationController?.pushViewController(vc, animated: true)
    }
}
