//
//  UserListViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/03.
//

import UIKit

protocol UserListDisplayLogic: class {
    func displayUserList(with: [User], at: UserListInteractor.UserSection)
}
class UserListViewController: BaseCollectionViewController<UserListInteractor.UserSection, User> {
    
    @IBOutlet weak var userCollectionView: UICollectionView!
    let interactor = UserListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewController = self
        configureCollectionView()
        interactor.fetchUsers()
    }
    
    private func configureCollectionView() {
        configureDataSource(collectionView: userCollectionView,
                            cellProvider: cellProvider(collectionView:indexPath:user:))
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        userCollectionView.collectionViewLayout = createLayout(using: configuration)
        userCollectionView.delegate = self
    }

    private func configureCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, User> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, User> { (cell, _, user) in
            var content = cell.defaultContentConfiguration()
            content.text = user.name
            content.imageProperties.cornerRadius = 3.0
            content.image = UIImage(systemName: "square.and.pencil") //우선 아무 image나 넣었습니다
            cell.contentConfiguration = content
        }
    }

    private func cellProvider(collectionView: UICollectionView,
                              indexPath: IndexPath,
                              user: User) -> UICollectionViewListCell? {
        let cell = collectionView.dequeueConfiguredReusableCell(using: configureCell(), for: indexPath, item: user)
        return cell
    }
    
}
extension UserListViewController: UserListDisplayLogic {
    
    func displayUserList(with users: [User], at section: UserListInteractor.UserSection) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(users, toSection: section)
        dataSource.apply(snapshot)
    }
    
}

extension UserListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedAuthor = dataSource.itemIdentifier(for: indexPath) else { return }
        interactor.select(user: selectedAuthor)
        navigationController?.popViewController(animated: true)
    }
    
}
