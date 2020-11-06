//
//  MilestoneListViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/28.
//

import UIKit

protocol MilestoneListDisplayLogic: class {
    func displayMilestoneList(with milestones: [Milestone], at section: MilestoneDataSource.Section)
}

class MilestoneListViewController: BaseCollectionViewController<MilestoneDataSource.Section, Milestone> {
    @IBOutlet weak var milestoneCollectionView: UICollectionView!
    let interactor = MilestoneListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        interactor.viewController = self
        interactor.fetchMilestoneList()
    }

    @IBAction func didTouchAddMilestoneButton(_ sender: Any) {
        guard let alert = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MilestoneAlertViewController") as? MilestoneAlertViewController else { return }
        present(alert, animated: true, completion: nil)
        //        alert.delegate = self
        alert.configure(.add, milestone: nil)

    }
    
}

extension MilestoneListViewController {
    private func configureCollectionView() {
        configureDataSource(collectionView: milestoneCollectionView,
                            cellProvider: cellProvider(collectionView:indexPath:milestone:))
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        milestoneCollectionView.collectionViewLayout = createLayout(using: configuration)
        milestoneCollectionView.delegate = self
    }
    
    private func cellProvider(collectionView: UICollectionView,
                              indexPath: IndexPath,
                              milestone: Milestone) -> UICollectionViewListCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MilestoneCollectionViewCell",
                                                      for: indexPath) as? MilestoneCollectionViewCell
        cell?.configure(with: milestone)
        return cell
    }
}

extension MilestoneListViewController: MilestoneListDisplayLogic {
    func displayMilestoneList(with milestones: [Milestone], at section: MilestoneDataSource.Section) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(milestones, toSection: section)
        dataSource.apply(snapshot)
    }
}

extension MilestoneListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let milestone = dataSource.itemIdentifier(for: indexPath)
        guard let alert = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MilestoneAlertViewController") as? MilestoneAlertViewController else { return }
        present(alert, animated: true, completion: nil)
//        alert.delegate = self.interactor
        alert.configure(.edit, milestone: milestone)
    }
}
