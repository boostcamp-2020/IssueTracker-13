//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/28.
//

import UIKit

protocol IssueListDisplayLogic: class {
    func displayIssueList(with issues: [Issue], at section: IssueDataSource.Section)
}

class IssueListViewController: BaseCollectionViewController<IssueDataSource.Section, Issue> {

    @IBOutlet weak var issueCollectionView: UICollectionView!

    let interactor = IssueListInteractor()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        interactor.viewController = self
        interactor.fetchIssues()
    }

    func configureCollectionView() {
        configureDataSource(collectionView: issueCollectionView,
                            cellProvider: cellProvider(collectionView:indexPath:issue:))
        issueCollectionView.collectionViewLayout = createLayout()
    }

    func cellProvider(collectionView: UICollectionView,
                      indexPath: IndexPath,
                      issue: Issue) -> UICollectionViewListCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "configureDataSource",
                                                      for: indexPath) as? IssueCollectionViewCell
        cell?.configure(with: issue)
        return cell
    }

}

extension IssueListViewController: IssueListDisplayLogic {
    func displayIssueList(with issues: [Issue], at section: IssueDataSource.Section) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(issues, toSection: section)
        dataSource.apply(snapshot)
    }
}
