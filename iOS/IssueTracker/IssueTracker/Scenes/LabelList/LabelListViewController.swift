//
//  LabelListViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/28.
//

import UIKit

protocol LabelListDisplayLogic: class {
    func displayLabelList(with labels: [Label], at section: LabelDataSource.Section)
}

class LabelListViewController: BaseCollectionViewController<LabelDataSource.Section, Label> {

    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    let interactor = LabelListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        interactor.viewController = self
        interactor.fetchLabelList()
    }

}

extension LabelListViewController {
    private func configureCollectionView() {
        configureDataSource(collectionView: labelCollectionView,
                            cellProvider: cellProvider(collectionView:indexPath:label:))
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        labelCollectionView.collectionViewLayout = createLayout(using: configuration)
    }
    
    private func cellProvider(collectionView: UICollectionView,
                              indexPath: IndexPath,
                              label: Label) -> UICollectionViewListCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCollectionViewCell",
                                                      for: indexPath) as? LabelCollectionViewCell
        cell?.configure(with: label)
        return cell
    }
}

extension LabelListViewController: LabelListDisplayLogic {
    func displayLabelList(with labels: [Label], at section: LabelDataSource.Section) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(labels, toSection: section)
        dataSource.apply(snapshot)
    }
}
