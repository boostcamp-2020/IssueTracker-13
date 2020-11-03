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

    @IBAction func didTouchToolbarButton(_ sender: UIBarButtonItem) {
        guard let indexPaths = issueCollectionView.indexPathsForSelectedItems else { return }
        let issues = indexPaths.compactMap({ dataSource.itemIdentifier(for: $0)})
        switch sender.title {
        case "선택 이슈 삭제":
            interactor.remove(issues: issues)
        case "선택 이슈 닫기":
            interactor.close(issues: issues)
        default:
            break
        }
        changeEditingMode()
    }
    
    private func updateBarButtonItems() {
        var leftTitle: String
        var rightTitle: String
        
        switch issueCollectionView.isEditing {
        case true:
            leftTitle = isSelectedAll() ? "Deelect All" : "Select All"
            rightTitle = "Cancel"
        case false:
            leftTitle = "Filter"
            rightTitle = "Edit"
        }
        setNavigationTitle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: leftTitle,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTouchLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightTitle,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(changeEditingMode))
    }
    
    func isSelectedAll() -> Bool {
        let itemCount = dataSource.snapshot().numberOfItems(inSection: .main)
        let indexPathCount = issueCollectionView.indexPathsForSelectedItems?.count
        if indexPathCount == 0 {
            return false
        }
        return itemCount == indexPathCount
    }
    
    @objc func didTouchLeftBarButton() {
        switch issueCollectionView.isEditing {
        case true:
            let itemCount = dataSource.snapshot().numberOfItems(inSection: .main)
            let flag = isSelectedAll()
            for item in 0..<itemCount {
                let indexPath = IndexPath(item: item, section: 0)
                if !flag {
                    issueCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
                } else {
                    issueCollectionView.deselectItem(at: indexPath, animated: true)
                }
            }
        case false:
            performSegue(withIdentifier: "showFilterIssueViewController", sender: self)
        }
        updateBarButtonItems()
    }
    
    @objc func changeEditingMode() {
        guard let tabBar = tabBarController?.tabBar else { return }
        tabBar.isHidden = !tabBar.isHidden
        tabBar.alpha = isEditing ? 0.0 : 1.0
        issueCollectionView.isEditing = !issueCollectionView.isEditing
        toolbar.isHidden = !toolbar.isHidden
//        toolbar.heightAnchor.constraint(equalTo: tabBar.heightAnchor).isActive = true
        updateBarButtonItems()
    }
    
    func setNavigationTitle() {
        var title: String
        switch issueCollectionView.isEditing {
        case true:
            guard let indexPaths = issueCollectionView.indexPathsForSelectedItems else { return }
            let selectedItemsCount = indexPaths.count
            title = "\(selectedItemsCount)개 선택"
        case false:
            title = "이슈"
        }
        navigationItem.title = title
    }

}

extension IssueListViewController {
    private func handleSwipe(for action: UIContextualAction, item: Issue) {
        switch action.title {
        case "Delete":
            interactor.remove(issue: item)
        case "Close":
            interactor.close(issue: item)
        default:
            break
        }
    }
    
    private func configureCollectionView() {
        configureDataSource(collectionView: issueCollectionView,
                            cellProvider: cellProvider(collectionView:indexPath:issue:))
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.trailingSwipeActionsConfigurationProvider = { [weak self] (indexPath) in
            
            guard let item = self?.dataSource?.itemIdentifier(for: indexPath) else {
                return nil
            }

            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, _, completion) in
                self?.handleSwipe(for: action, item: item)
                completion(true)
            }

            let closeAction = UIContextualAction(style: .normal, title: "Close") { (action, _, completion) in
                self?.handleSwipe(for: action, item: item)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [closeAction, deleteAction])
        }
        issueCollectionView.collectionViewLayout = createLayout(using: configuration)
        issueCollectionView.allowsMultipleSelectionDuringEditing = true
        issueCollectionView.delegate = self
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

extension IssueListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setNavigationTitle()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        setNavigationTitle()
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
