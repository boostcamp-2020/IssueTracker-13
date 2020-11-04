//
//  FilterMilestoneListViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/04.
//

import UIKit

protocol FilterMilestoneDisplayLogic: class {
    func displayMilestoneList(with: [String], at: FilterMilestoneListInteractor.MilestoneSection)
}

class FilterMilestoneListViewController: BaseCollectionViewController<FilterMilestoneListInteractor.MilestoneSection, String> {

    @IBOutlet weak var milestoneCollectionView: UICollectionView!
    
    let interactor = FilterMilestoneListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewController = self
        configureCollectionView()
        interactor.fetchMilestones()
    }
    
    private func configureCollectionView() {
        configureDataSource(collectionView: milestoneCollectionView,
                            cellProvider: cellProvider(collectionView:indexPath:milestone:))
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        milestoneCollectionView.collectionViewLayout = createLayout(using: configuration)
        milestoneCollectionView.delegate = self
    }

    private func configureCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, String> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, _, milestone) in
            var content = cell.defaultContentConfiguration()
            content.text = milestone
            content.textProperties.alignment = .center
            cell.contentConfiguration = content
        }
    }

    private func cellProvider(collectionView: UICollectionView,
                              indexPath: IndexPath,
                              milestone: String) -> UICollectionViewListCell? {
        let cell = collectionView.dequeueConfiguredReusableCell(using: configureCell(), for: indexPath, item: milestone)
        return cell
    }

}

extension FilterMilestoneListViewController: FilterMilestoneDisplayLogic {
    
    func displayMilestoneList(with milestone: [String], at section: FilterMilestoneListInteractor.MilestoneSection) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(milestone, toSection: section)
        dataSource.apply(snapshot)
    }
    
}

extension FilterMilestoneListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMilestone = dataSource.itemIdentifier(for: indexPath) else { return }
        interactor.select(milestone: selectedMilestone)
        navigationController?.popViewController(animated: true)
    }
    
}
