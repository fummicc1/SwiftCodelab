//
//  ViewController.swift
//  CompositionalLayoutApp
//
//  Created by Fumiya Tanaka on 2020/05/19.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    private weak var label: UILabel?
    
    var text: String! {
        didSet {
            label?.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        self.label = label
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class ViewController: UIViewController {
    private weak var collectionView: UICollectionView?
    private let dataStore = (0...500).map { "Number: \($0 * 100)" }
    private lazy var dataProvider: UICollectionViewDiffableDataSource<Section, String> = {
        guard let collectionView = collectionView else {
            assert(false)
            return .init()
        }
        return .init(collectionView: collectionView) { (collectionView, indexPath, item) -> CollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell
            cell?.text = item
            return cell
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        updateCollectionViewData()
    }
    
    private func updateCollectionViewData() {
        var snapshot = dataProvider.snapshot()
        if let section = snapshot.sectionIdentifiers.lazy.first(where: { $0 == .main }) {
            snapshot.deleteSections([section])
        }
        snapshot.appendSections([.main])
        snapshot.appendItems(dataStore, toSection: .main)
        dataProvider.apply(snapshot)
    }
    
    private func configureView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        self.collectionView = collectionView
    }
    
    private func createSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0)), subitems: [item])
        let parentGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)), subitems: [group])
        let section = NSCollectionLayoutSection(group: parentGroup)
        return section
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return .init(sectionProvider: { (_, environment) -> NSCollectionLayoutSection? in
            self.createSection()
        })
    }
}

extension ViewController {
    enum Section: Hashable {
        case main
    }
}
