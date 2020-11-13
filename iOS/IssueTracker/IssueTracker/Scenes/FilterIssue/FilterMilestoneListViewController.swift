//
//  FilterMilestoneListViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/04.
//

import UIKit

protocol FilterMilestoneDisplayLogic: class {
    func displayMilestoneList(with: [FilterMilestoneListInteractor.MilestoneSection: [Milestone]])
}

class FilterMilestoneListViewController: BaseCollectionViewController<FilterMilestoneListInteractor.MilestoneSection, Milestone> {

    @IBOutlet weak var milestoneCollectionView: UICollectionView!
    
    let interactor = FilterMilestoneListInteractor()
    var milestone: Milestone?
    @IBAction func didTouchDoneButton(_ sender: Any) {
        let rows = dataSource.collectionView(milestoneCollectionView, numberOfItemsInSection: 0)
        let milestones = (0...rows).compactMap({dataSource.itemIdentifier(for: IndexPath(row: $0, section: 0))})

        if let milestone = milestones.first {
            interactor.select(milestone: milestone)
        } else {
            interactor.deselect()
        }
        navigationController?.popViewController(animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewController = self
        configureCollectionView()
        interactor.selectedMilestone = self.milestone
        interactor.fetchMilestones(with: self.milestone)
    }
    
    private func configureCollectionView() {
        configureDataSource(collectionView: milestoneCollectionView,
                            cellProvider: cellProvider(collectionView:indexPath:milestone:))
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.headerMode = .supplementary
        milestoneCollectionView.collectionViewLayout = createLayout(using: configuration)
        milestoneCollectionView.delegate = self
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) {
            [unowned self] (headerView, elementKind, indexPath) in
            let headerItem = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            var configuration = headerView.defaultContentConfiguration()
            configuration.text = headerItem.rawValue
            headerView.contentConfiguration = configuration
        }
        dataSource.supplementaryViewProvider = { [unowned self]
            (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            if elementKind == UICollectionView.elementKindSectionHeader {
                return self.milestoneCollectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration, for: indexPath)
            }
            return nil
        }
    }

    private func configureCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, String> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, _, milestone) in
            var content = cell.defaultContentConfiguration()
            content.text = milestone
            cell.contentConfiguration = content
        }
    }

    private func cellProvider(collectionView: UICollectionView,
                              indexPath: IndexPath,
                              milestone: Milestone) -> UICollectionViewListCell? {
        let cell = collectionView.dequeueConfiguredReusableCell(using: configureCell(), for: indexPath, item: milestone.title)
        return cell
    }

}

extension FilterMilestoneListViewController: FilterMilestoneDisplayLogic {
    
    func displayMilestoneList(with: [FilterMilestoneListInteractor.MilestoneSection: [Milestone]]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.selected, .main])
        snapshot.appendItems(with[.main] ?? [], toSection: .main)
        snapshot.appendItems(with[.selected] ?? [], toSection: .selected)
        dataSource.apply(snapshot)
    }
    
}

extension FilterMilestoneListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMilestone = dataSource.itemIdentifier(for: indexPath) else { return }
        let section = indexPath.section == 1 ? 0 : 1
        var row = dataSource.collectionView(collectionView, numberOfItemsInSection: section)
        if section == 0 && row == 1 {
            let toRow = dataSource.collectionView(collectionView, numberOfItemsInSection: 1)
            dataSource.collectionView(collectionView, moveItemAt: IndexPath(row: 0, section: 0), to: IndexPath(row: toRow, section: 1))
        }
//        interactor.select(milestone: selectedMilestone)
        row = dataSource.collectionView(collectionView, numberOfItemsInSection: section)

        dataSource.collectionView(collectionView, moveItemAt: indexPath, to: IndexPath(row: row, section: section))
//        navigationController?.popViewController(animated: true)
    }
    
}
