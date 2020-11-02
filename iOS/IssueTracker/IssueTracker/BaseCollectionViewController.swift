//
//  BaseCollectionViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/29.
//

import UIKit

class BaseCollectionViewController<T: Hashable, U: Hashable>: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<T, U>! = nil
    typealias DataSource = UICollectionViewDiffableDataSource<T, U>
    typealias Snapshot = NSDiffableDataSourceSnapshot<T, U>

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func createLayout(using configuration: UICollectionLayoutListConfiguration) -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }

    func configureDataSource(collectionView: UICollectionView,
                             cellProvider: @escaping (UICollectionView, IndexPath, U) -> UICollectionViewListCell?) {
        dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
    }

}
