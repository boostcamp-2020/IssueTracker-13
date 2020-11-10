//
//  LabelListViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/28.
//

import UIKit

protocol LabelListDisplayLogic: class {
    func displayLabelList(with labels: [Label], at section: LabelDataSource.Section)
}

class LabelListViewController: BaseCollectionViewController<LabelDataSource.Section, Label> {

    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    let interactor = LabelListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        interactor.viewController = self
        interactor.fetchLabelList()
    }

    @IBAction func didTouchAddLabelButton(_ sender: Any) {
        guard let alert = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LabelAlertViewController") as? LabelAlertViewController else { return }
        present(alert, animated: true, completion: nil)
//        alert.delegate = self
        alert.configure(.add, label: nil)
    }
    
}

extension LabelListViewController {
    private func configureCollectionView() {
        configureDataSource(collectionView: labelCollectionView,
                            cellProvider: cellProvider(collectionView:indexPath:label:))
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        labelCollectionView.collectionViewLayout = createLayout(using: configuration)
        labelCollectionView.delegate =  self
    }
    
    private func cellProvider(collectionView: UICollectionView,
                              indexPath: IndexPath,
                              label: Label) -> UICollectionViewListCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCollectionViewCell",
                                                      for: indexPath) as? LabelCollectionViewCell
        cell?.configure(with: label)
        return cell
    }
}

extension LabelListViewController: LabelListDisplayLogic {
    func displayLabelList(with labels: [Label], at section: LabelDataSource.Section) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(labels, toSection: section)
        dataSource.apply(snapshot)
    }
}

extension LabelListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let label = dataSource.itemIdentifier(for: indexPath)
        guard let alert = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LabelAlertViewController") as? LabelAlertViewController else { return }
        present(alert, animated: true, completion: nil)
//        alert.interactor.delegate = self
        alert.configure(.edit, label: label)
    }
}
