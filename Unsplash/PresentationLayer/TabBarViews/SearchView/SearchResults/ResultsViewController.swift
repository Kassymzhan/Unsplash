//
//  ResultsVC.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 02.05.2022.
//

import UIKit

protocol ResultsViewControllerDelegate: AnyObject {
    func showOpenedPhotoViewController(photo: Photo)
    
    func showOpenedCollectionsViewController(collection: Collection)
}

class ResultsViewController: UIViewController {
    private let viewModel: UnsplashViewModel
    
    weak var delegate: ResultsViewControllerDelegate?
    
    var searchText: String? {
        didSet {
            guard let searchText = searchText, !searchText.isEmpty else { return }
            switch searchSubjectSegmentedControl.selectedSegmentIndex {
            case 0:
                photoSearchCollectionViewSetUp()
                viewModel.getSearchPhotos(query: searchText)
            case 1:
                collectionSearchCollectionViewSetUp()
                viewModel.getSearchCollections(query: searchText)
            case 2:
                userTableViewSetUp()
                viewModel.getSearchUsers(query: searchText)
            default: break
            }
        }
    }
    
    private var items: [CellConfigurator] = []
    
    private lazy var tableDirector: TableDirector = {
        let tableDirector = TableDirector(tableView: tableView, items: items)
        return tableDirector
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
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
        segmentControl.addTarget(self, action: #selector(didSwitchSegmentedContol), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.tintColor = .label
        return segmentControl
    }()
    
    private let photoSearchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let collectionSearchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 1
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionsCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        searchSubjectConfigure()
        tableDirector.tableView.reloadData()
        bindViewModel()
        cellActionHandlers()
    }
    
    @objc func didSwitchSegmentedContol() {
        guard let searchText = searchText, !searchText.isEmpty else { return }
        switch searchSubjectSegmentedControl.selectedSegmentIndex {
        case 0:
            photoSearchCollectionViewSetUp()
            viewModel.getSearchPhotos(query: searchText)
        case 1:
            collectionSearchCollectionViewSetUp()
            viewModel.getSearchCollections(query: searchText)
        case 2:
            userTableViewSetUp()
            viewModel.getSearchUsers(query: searchText)
        default: break
        }
    }
    
    private func buildPhotosCells() {
        photoSearchCollectionView.reloadData()
    }
    
    private func buildCollectionsCells() {
        collectionSearchCollectionView.reloadData()
    }
    
    private func buildUsersCells() {
        items.removeAll()
        let users = viewModel.users.map { users in
            UserPO(id: users.id, username: users.username, name: users.name, firstName: users.firstName, secondName: users.secondName, instagramUsername: users.instagramUsername, totalLikes: users.totalLikes, totalPhotos: users.totalPhotos, totalCollections: users.totalCollections, profileImage: users.profileImage)
        }
        var cellConfigurators: [UserCellConfigurator] = []
        for user in users {
            let config = UserCellConfigurator(item: user)
            cellConfigurators.append(config)
        }
        tableDirector.items = cellConfigurators
        tableDirector.tableView.reloadData()
    }
    
    private func bindViewModel() {
        viewModel.didLoadPhotos = { [weak self] _ in
            self?.buildPhotosCells()
        }
        viewModel.didGetSearchPhotos = {[weak self] _ in
            self?.buildPhotosCells()
        }
        viewModel.didGetSearchCollections = {[weak self] _ in
            self?.buildCollectionsCells()
        }
        viewModel.didGetSearchUsers = {[weak self] _ in
            self?.buildUsersCells()
        }
    }
    
    private func cellActionHandlers() {
        self.tableDirector.actionProxy
            .on(action: .didSelect) { (config: UserCellConfigurator, cell) in
                let vc = UserDetailsViewController()
                vc.userName = config.item.username
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .on(action: .willDisplay) { (config: UserCellConfigurator, cell) in
                cell.backgroundColor = .secondarySystemBackground
            }.on(action: .custom(UserCell.didTapButtonAction)) { (config: UserCellConfigurator, cell) in

            }
    }

    
    private func photoSearchCollectionViewSetUp() {
        collectionSearchCollectionView.removeFromSuperview()
        tableView.removeFromSuperview()
        view.addSubview(photoSearchCollectionView)
        photoSearchCollectionView.delegate = self
        photoSearchCollectionView.dataSource = self
        photoSearchCollectionView.snp.makeConstraints() {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(64)
        }
    }
    
    private func collectionSearchCollectionViewSetUp() {
        photoSearchCollectionView.removeFromSuperview()
        tableView.removeFromSuperview()
        view.addSubview(collectionSearchCollectionView)
        collectionSearchCollectionView.delegate = self
        collectionSearchCollectionView.dataSource = self
        collectionSearchCollectionView.snp.makeConstraints() {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(64)
        }
    }
    
    private func userTableViewSetUp() {
        photoSearchCollectionView.removeFromSuperview()
        collectionSearchCollectionView.removeFromSuperview()
        view.addSubview(tableView)
        tableView.snp.makeConstraints() {
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
extension ResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch searchSubjectSegmentedControl.selectedSegmentIndex {
        case 0:
            let photo = viewModel.photos[indexPath.startIndex]
            return CGSize(width: (collectionView.frame.width / 2) - 1, height: CGFloat(photo.height/16))
        case 1:
            return CGSize(width: collectionView.frame.width, height: 250)
        default:
            let photo = viewModel.photos[indexPath.startIndex]
            return CGSize(width: (collectionView.frame.width / 2) - 1, height: CGFloat(photo.height/16))
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch searchSubjectSegmentedControl.selectedSegmentIndex {
        case 0:
            delegate!.showOpenedPhotoViewController(photo: viewModel.photos[indexPath.row])
        case 1:
            delegate!.showOpenedCollectionsViewController(collection: viewModel.collections[indexPath.row])
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch searchSubjectSegmentedControl.selectedSegmentIndex {
        case 0:
            return viewModel.photos.count
        case 1:
            return viewModel.collections.count
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch searchSubjectSegmentedControl.selectedSegmentIndex {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DiscoverCell
            cell.data = viewModel.photos[indexPath.row]
            return cell
        case 1:
            let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionsCell
            collectionCell.data = viewModel.collections[indexPath.row]
            return collectionCell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionsCell
            cell.data = viewModel.collections[indexPath.row]
            return cell
        }
    }
}
