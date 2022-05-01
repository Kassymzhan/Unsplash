//
//  FeedView.swift
//  Unsplash
//
//  Created by Нурым Нагиметов on 30.04.2022.
//

import UIKit
import SnapKit
import LZViewPager
class FeedView: UIViewController {
    private let viewPager = LZViewPager(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    
    private var subControllers: [UIViewController] = []
    
    private let tableView : UITableView = {
        let table = UITableView()
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(viewPager)
        constraintTableView()
        configureNavigationBar()
        viewPagerProperties()
    }

    private func configureNavigationBar(){
        navigationItem.title = "Unsplash"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .done, target: nil, action: .none)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
    }
    
    private func viewPagerProperties(){
        viewPager.dataSource = self
        viewPager.delegate = self
        viewPager.hostController = self
        
        let vc1 = SearchView()
        let vc2 = AddView()
        let vc3 = ProfileView()
        let vc4 = SearchView()
        let vc5 = AddView()
        let vc6 = ProfileView()
        vc1.title = "Editoril"
        vc2.title = "Current Events"
        vc3.title = "Wallpapers"
        vc4.title = "3D Renders"
        vc5.title = "Textures"
        vc6.title = "Experimental"
        subControllers = [vc1, vc2, vc3, vc4,vc5,vc6]
        viewPager.reload()
    }
    private func constraintTableView() {
        viewPager.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
}
// MARK: -  TableView datasource extensoin

extension FeedView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
// MARK: -  TableView delegate extensoin

extension FeedView: UITableViewDelegate {

}
// MARK: - Pager view delegate extensoin

extension FeedView: LZViewPagerDelegate {
    
}
// MARK: - Pager view datasource extensoin

extension FeedView: LZViewPagerDataSource {
    func numberOfItems() -> Int {
        return self.subControllers.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return subControllers[index]
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }
    func colorForIndicator(at index: Int) -> UIColor {
        return .blue
    }
    
    func shouldEnableSwipeable() -> Bool {
        return true
    }
    
    
}
