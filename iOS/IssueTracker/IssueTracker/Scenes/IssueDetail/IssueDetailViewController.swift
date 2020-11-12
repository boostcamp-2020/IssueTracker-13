//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/09.
//

import UIKit
import FloatingPanel

protocol IssueDetailDisplayLogic: class {
    func displayActionSheet(for :Int)
    func displayCommentList(with: [Comment], at: IssueDetailDataSource.Section)
    func scrollToComment(at index: Int)
}
class IssueDetailViewController: BaseCollectionViewController<IssueDetailDataSource.Section, Comment> {
    
    @IBOutlet weak var commentCollectionView: UICollectionView!

    let interactor = IssueDetailInteractor()

    var issue: Issue?
    var bottomSheet = FloatingPanelController()

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewController = self
        tabBarController?.tabBar.isHidden = true
        configureBottomSheet()
        configureCollectionView()
        configureNavigationBar()
        interactor.fetchComments()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowIssueEditViewController" {
            let navigationViewController = segue.destination as? UINavigationController
            let viewController = navigationViewController?.viewControllers.first as? IssueEditViewController
            viewController?.issue = interactor.issue
        }
    }
    
    @IBAction func didTouchEditButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ShowIssueEditViewController", sender: interactor.issue)
    }
    
}
extension IssueDetailViewController {
    
    private func configureNavigationBar() {
        title = interactor.issue?.title
    }

    private func configureCollectionView() {
        configureDataSource(collectionView: commentCollectionView,
                            cellProvider: cellProvider(collectionView:indexPath:comment:))
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.headerMode = .supplementary
        configuration.showsSeparators = false
        dataSource.supplementaryViewProvider = { (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            if elementKind == UICollectionView.elementKindSectionHeader {
                let commentHeaderView = self.commentCollectionView
                    .dequeueReusableSupplementaryView(ofKind: elementKind,
                                                      withReuseIdentifier: "CommentCollectionReusableView",
                                                      for: indexPath) as? CommentCollectionReusableView
                guard let issue = self.interactor.issue else { return UICollectionReusableView()}
                commentHeaderView?.configure(with: issue)
                return commentHeaderView
            } else {
                return UICollectionReusableView()
            }
        }
        commentCollectionView.collectionViewLayout = createLayout(using: configuration)
    }

    private func cellProvider(collectionView: UICollectionView,
                              indexPath: IndexPath,
                              comment: Comment) -> UICollectionViewListCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCollectionViewCell",
                                                      for: indexPath) as? CommentCollectionViewCell
        cell?.confiugre(with: comment)
        cell?.didTouchMenuButton = { [weak self] (id) in
            self?.displayActionSheet(for: id)
        }
        return cell
    }
    
}

extension IssueDetailViewController: IssueDetailDisplayLogic {
    func displayCommentList(with comments: [Comment], at section: IssueDetailDataSource.Section) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(comments, toSection: section)
        dataSource.apply(snapshot)
    }
    
    func displayActionSheet(for commentID: Int) {
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let editAction = UIAlertAction(title: "수정", style: .default) { (action) in
            print(commentID)
        }
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { (action) in

        }
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(cancelAction)
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }

    func scrollToComment(at index: Int) {
        
    }
}

extension IssueDetailViewController: FloatingPanelControllerDelegate {
    func configureBottomSheet() {
        bottomSheet.delegate = self // Optional

        // Set a content view controller.
        guard let contentVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "IssueBottomSheetViewController", creator: { (coder) in
            return IssueBottomSheetViewController(coder: coder, issue: self.interactor.issue)
        }) as? IssueBottomSheetViewController else { return }
        bottomSheet.set(contentViewController: contentVC)

        // Track a scroll view(or the siblings) in the content view controller.
//        bottomSheet.track(scrollView: contentVC.tableView)

        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        bottomSheet.addPanel(toParent: self)
    }
}
