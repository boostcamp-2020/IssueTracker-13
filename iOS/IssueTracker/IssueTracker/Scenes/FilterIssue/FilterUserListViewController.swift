//
//  UserListViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/03.
//

import UIKit

protocol FilterUserListDisplayLogic: class {
    func displayUserList(with: [User], at: FilterUserListInteractor.UserSection)
}

class FilterUserListViewController: BaseCollectionViewController<FilterUserListInteractor.UserSection, User> {
    
    @IBOutlet weak var userCollectionView: UICollectionView!
    let interactor = FilterUserListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewController = self
        configureCollectionView()
        interactor.fetchUsers()
        guard let userMode = interactor.userMode else { return }
        title = userMode.rawValue
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
            content.text = user.userName
            content.imageProperties.cornerRadius = 3.0
            cell.contentConfiguration = content
            
            let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            profileImageView.loadImageUsingCache(with: user.profile)
            profileImageView.contentMode = .scaleAspectFit
            cell.accessories = [.customView(configuration: .init(customView: profileImageView, placement: .leading(displayed: .always, at: { (accesory) -> Int in
                0
            }), isHidden: false, reservedLayoutWidth: nil, tintColor: nil, maintainsFixedSize: true))]
            cell.contentView.addSubview(profileImageView)
        }
    }

    private func cellProvider(collectionView: UICollectionView,
                              indexPath: IndexPath,
                              user: User) -> UICollectionViewListCell? {
        let cell = collectionView.dequeueConfiguredReusableCell(using: configureCell(), for: indexPath, item: user)
        return cell
    }
    
}
extension FilterUserListViewController: FilterUserListDisplayLogic {
    
    func displayUserList(with users: [User], at section: FilterUserListInteractor.UserSection) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(users, toSection: section)
        dataSource.apply(snapshot)
    }
    
}

extension FilterUserListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedUser = dataSource.itemIdentifier(for: indexPath) else { return }
        interactor.select(user: selectedUser)
        navigationController?.popViewController(animated: true)
    }
    
}
