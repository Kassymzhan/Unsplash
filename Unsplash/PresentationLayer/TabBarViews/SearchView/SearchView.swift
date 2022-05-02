//
//  SearchView.swift
//  Unsplash
//
//  Created by Нурым Нагиметов on 30.04.2022.
//

import UIKit

struct Discover: Decodable {
    let imageUrl: String
    let name: String
    let height: Int
}

class SearchView: UIViewController {
    private let viewModel: UnsplashViewModel

    private var items: [Discover] = []
    
    init(viewModel: UnsplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: ResultsVC(viewModel: UnsplashViewModel(service: PhotosServiceImpl())))
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search photos, collections, users",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        return searchController
    }()

    let DiscoverCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didTapCell)))
        return image
    }()
    
    @objc func didTapCell() {
        print("123")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        searchController.searchBar.delegate = self
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationController?.navigationBar.backgroundColor = .systemBackground
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
        viewModel.didGetSearchPhotos = {[weak self] _ in
            ResultsVC(viewModel: self!.viewModel).buildCells()
        }
        viewModel.didGetCollectionPhotos = {[weak self] _ in
            self?.buildCells()            
        }
    }

    private func buildCells() {
        let photos = viewModel.photos.map { photo in
            PhotoPO(id: photo.id, width: photo.width, height: photo.height, color: photo.color, description: photo.description, createdAt: photo.createdAt, urls: photo.urls.small, user: photo.user)
        }
        for photo in photos {
            let config = Discover(imageUrl: photo.urls, name: photo.user.name, height: photo.height)
            items.append(config)
        }
        DiscoverCollectionView.reloadData()
    }

    private func collectionViewSetUp() {

        
        view.addSubview(DiscoverCollectionView)
        DiscoverCollectionView.dataSource = self
        DiscoverCollectionView.delegate = self
        DiscoverCollectionView.snp.makeConstraints(){
            $0.leading.trailing.bottom.top.equalTo(view.safeAreaLayoutGuide)
//            $0.top.equalTo(CategoriesCollectionView.snp.bottom).offset(50)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        DiscoverCollectionView.backgroundColor = .systemBackground
    }
}

extension SearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = items[indexPath.startIndex]
        return CGSize(width: (collectionView.frame.width / 2) - 1, height: CGFloat(photo.height/20))
    }
}

extension SearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DiscoverCell
        cell.data = self.items[indexPath.row]
        return cell
    }
}

extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getSearchPhotos(query: searchBar.text!)
    }

//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        <#code#>
//    }
}
