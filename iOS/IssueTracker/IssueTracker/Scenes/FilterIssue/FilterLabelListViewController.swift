//
//  FilterLabelListViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/04.
//

import UIKit

protocol FilterLabelListDisplayLogic: class {
    func displayLabelList(with: [Label], at: FilterLabelInteractor.LabelSection)
}

class FilterLabelListViewController: BaseCollectionViewController<FilterLabelInteractor.LabelSection, Label> {
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    let interactor = FilterLabelInteractor()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        interactor.viewController = self
        interactor.fetchLabels()
    }

    private func configureCollectionView() {
        configureDataSource(collectionView: labelCollectionView,
                            cellProvider: cellProvider(collectionView:indexPath:label:))
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        labelCollectionView.collectionViewLayout = createLayout(using: configuration)
        labelCollectionView.delegate = self
    }

    private func configureCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, Label> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, Label> { (cell, _, label) in
            var content = cell.defaultContentConfiguration()
            content.text = label.title
            let rect = CGRect(origin: .zero, size: CGSize(width: 10, height: 10))
            content.imageProperties.cornerRadius = 20.0
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
            UIColor.black.setFill()
            UIRectFill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            guard let cgImage = image?.cgImage else { return  }
            content.image = UIImage(cgImage: cgImage)
            cell.contentConfiguration = content
        }
    }

    private func cellProvider(collectionView: UICollectionView,
                              indexPath: IndexPath,
                              label: Label) -> UICollectionViewListCell? {
        let cell = collectionView.dequeueConfiguredReusableCell(using: configureCell(), for: indexPath, item: label)
        return cell
    }
}

extension FilterLabelListViewController: FilterLabelListDisplayLogic {
    func displayLabelList(with labels: [Label], at section: FilterLabelInteractor.LabelSection) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(labels, toSection: section)
        dataSource.apply(snapshot)
    }
    
}

extension FilterLabelListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let label = dataSource.itemIdentifier(for: indexPath) else { return }
        interactor.select(label: label)
        navigationController?.popViewController(animated: true)
    }
}
