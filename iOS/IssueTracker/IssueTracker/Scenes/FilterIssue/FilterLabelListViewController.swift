//
//  FilterLabelListViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/04.
//

import UIKit

protocol FilterLabelListDisplayLogic: class {
    func displayLabelList(with: [FilterLabelInteractor.LabelSection: [Label]])
}

class FilterLabelListViewController: BaseCollectionViewController<FilterLabelInteractor.LabelSection, Label> {
    enum Mode {
        case filter
        case edit
    }
    @IBAction func didTouchDoneButton(_ sender: UIBarButtonItem) {
        let rows = dataSource.collectionView(labelCollectionView, numberOfItemsInSection: 0)
        let labels = (0...rows).compactMap({dataSource.itemIdentifier(for: IndexPath(row: $0, section: 0))})
        guard let mode = self.mode else { return }
        if mode == .edit {
            interactor.select(labels: labels)
        } else {
            if let label = labels.first {
                interactor.select(label: label)
            } else {
                interactor.reset()
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var labelCollectionView: UICollectionView!
    var labels: [Label]?
    let interactor = FilterLabelInteractor()
    var mode: Mode?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        interactor.viewController = self
        interactor.fetchLabels(with: self.labels ?? [])
    }

    private func configureCollectionView() {
        configureDataSource(collectionView: labelCollectionView,
                            cellProvider: cellProvider(collectionView:indexPath:label:))
       
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.headerMode = .supplementary
        labelCollectionView.collectionViewLayout = createLayout(using: configuration)
        labelCollectionView.delegate = self
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) {
            [unowned self] (headerView, elementKind, indexPath) in
            let headerItem = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            var configuration = headerView.defaultContentConfiguration()
            configuration.text = headerItem.rawValue
            headerView.contentConfiguration = configuration
        }
        dataSource.supplementaryViewProvider = { [unowned self]
            (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            if elementKind == UICollectionView.elementKindSectionHeader {
                return self.labelCollectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration, for: indexPath)
            }
            return nil
        }
    }

    private func configureCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, Label> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, Label> { (cell, _, label) in
            var content = cell.defaultContentConfiguration()
            content.text = label.title
            let rect = CGRect(origin: .zero, size: CGSize(width: 10, height: 10))
            content.imageProperties.cornerRadius = 20.0
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
            UIColor(hexString: label.backgroundColor ?? "#000000").setFill()
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
    func displayLabelList(with sections: [FilterLabelInteractor.LabelSection: [Label]]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.selected, .main])
        snapshot.appendItems(sections[.selected] ?? [], toSection: .selected)
        snapshot.appendItems(sections[.main] ?? [], toSection: .main)
        dataSource.apply(snapshot)
    }
    
}

extension FilterLabelListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let label = dataSource.itemIdentifier(for: indexPath) else { return }
        let section = indexPath.section == 1 ? 0 : 1
        var row = dataSource.collectionView(collectionView, numberOfItemsInSection: section)
        
        switch self.mode {
        case .filter:
            if section == 0 && row == 1 {
                let toRow = dataSource.collectionView(collectionView, numberOfItemsInSection: 1)
                dataSource.collectionView(collectionView, moveItemAt: IndexPath(row: 0, section: 0), to: IndexPath(row: toRow, section: 1))
            }
//            interactor.select(label: label)
        case .edit:
            break

        case .none:
            break
        }
        row = dataSource.collectionView(collectionView, numberOfItemsInSection: section)
        dataSource.collectionView(collectionView, moveItemAt: indexPath, to: IndexPath(row: row, section: section))

//        navigationController?.popViewController(animated: true)
    }
}
