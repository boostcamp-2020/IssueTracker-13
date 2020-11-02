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
    @IBOutlet weak var toolbar: UIToolbar!
    
    let interactor = IssueListInteractor()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        interactor.viewController = self
        interactor.fetchIssues()
        updateBarButtonItems()
    }

    @IBAction func didTouchSelectedIssuesDeleteButton(_ sender: UIBarButtonItem) {
        print(issueCollectionView.indexPathsForSelectedItems)
    }
    
    @IBAction func didTouchSelectedIssuesCloseButton(_ sender: UIBarButtonItem) {
    }
    
    private func updateBarButtonItems() {
        var leftTitle: String
        var rightTitle: String
        
        switch issueCollectionView.isEditing {
        case true:
            leftTitle = "Select All"
            rightTitle = "Cancel"
        case false:
            leftTitle = "Filter"
            rightTitle = "Edit"
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: leftTitle,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTouchLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightTitle,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTouchRightBarButton))
    }
    
    @objc func didTouchLeftBarButton() {
        switch issueCollectionView.isEditing {
        case true:
            let itemCount = dataSource.snapshot().numberOfItems(inSection: .main)
            for item in 0..<itemCount {
                let indexPath = IndexPath(item: item, section: 0)
                issueCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
            }
        case false:
            performSegue(withIdentifier: "showFilterViewController", sender: self)
        }
        updateBarButtonItems()
    }
    
    @objc func didTouchRightBarButton() {
        guard let tabBar = tabBarController?.tabBar else { return }
        tabBar.isHidden = !tabBar.isHidden
        issueCollectionView.isEditing = !issueCollectionView.isEditing
        toolbar.isHidden = !toolbar.isHidden
        toolbar.heightAnchor.constraint(equalTo: tabBar.heightAnchor).isActive = true
        updateBarButtonItems()
    }

}

extension IssueListViewController {
    
    private func configureCollectionView() {
        configureDataSource(collectionView: issueCollectionView,
                            cellProvider: cellProvider(collectionView:indexPath:issue:))
        issueCollectionView.collectionViewLayout = createLayout()
        issueCollectionView.allowsMultipleSelectionDuringEditing = true
    }

    private func cellProvider(collectionView: UICollectionView,
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
