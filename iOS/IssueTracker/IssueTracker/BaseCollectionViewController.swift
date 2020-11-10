//
//  BaseCollectionViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/29.
//

import UIKit

protocol RefreshDisplayable {
    func configureRefreshControl(with collectionview: UICollectionView)
}

class BaseCollectionViewController<T: Hashable, U: Hashable>: UIViewController {

    let refreshControl = UIRefreshControl()
    var didBeginRefresh: (() -> Void)?
    
    var dataSource: UICollectionViewDiffableDataSource<T, U>! = nil
    typealias DataSource = UICollectionViewDiffableDataSource<T, U>
    typealias Snapshot = NSDiffableDataSourceSnapshot<T, U>

    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true
    }

    func createLayout(using configuration: UICollectionLayoutListConfiguration) -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }

    func configureDataSource(collectionView: UICollectionView,
                             cellProvider: @escaping (UICollectionView, IndexPath, U) -> UICollectionViewListCell?) {
        dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing == true {
            didBeginRefresh?()
        }
    }

}
