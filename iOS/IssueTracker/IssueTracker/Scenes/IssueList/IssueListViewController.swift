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

class IssueListViewController: UIViewController {

    @IBOutlet weak var issueCollectionView: UICollectionView!

    let interactor = IssueListInteractor()

    private var dataSource: DataSource! = nil
    typealias DataSource = UICollectionViewDiffableDataSource<IssueDataSource.Section, Issue>
    typealias Snapshot = NSDiffableDataSourceSnapshot<IssueDataSource.Section, Issue>

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewController = self
        interactor.fetchIssueList()
    }

    func configureCollectionView() {
        configureDataSource()
        issueCollectionView.collectionViewLayout = createLayout()
    }

    func configureDataSource() {
        dataSource = DataSource(collectionView: issueCollectionView,
                                cellProvider: { (collectionView, indexPath, issue) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "configureDataSource",
                                                          for: indexPath) as? IssueCollectionViewCell
                                    cell?.configure(with: issue)
            return cell
        })
    }

    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }

}

extension IssueListViewController: IssueListDisplayLogic {
    func displayIssueList(with issues: [Issue], at section: IssueDataSource.Section) {
    }
}
