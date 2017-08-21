//
//  BarView.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/21/17.
//
//

import UIKit

public
class BarView: UICollectionView,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {

    // MARK: Properties

    var model: [String] = [] {
        didSet {
            reloadData()
        }
    }

    private
    let layout: UICollectionViewFlowLayout = {
        let l = UICollectionViewFlowLayout()
        l.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        l.minimumLineSpacing = 5.0
        l.minimumInteritemSpacing = 0
        l.scrollDirection = .horizontal
        l.estimatedItemSize = l.itemSize

        return l
    }()

    // MARK: Initialization

    init() {
        super.init(frame: .zero, collectionViewLayout: layout)

        dataSource = self
        delegate = self
        register(BarItemCell.self, forCellWithReuseIdentifier: BarItemCell.reuseIdentifier)
    }

    required public
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UICollectionViewDataSource

    public
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }

    public
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(
            withReuseIdentifier: BarItemCell.reuseIdentifier,
            for: indexPath
        )
    }

    public
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        (cell as? BarItemCell)?.model = model[indexPath.item]
    }

    public
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: 100,
            height: collectionView.frame.size.height
        )
    }

    public
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .zero
    }

}
