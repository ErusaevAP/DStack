//
//  CollectionViewControllerSmall.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/21/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CollectionViewControllerSmall: UICollectionViewController {

    private
    lazy var refreshControl: UIRefreshControl = {
        let r = UIRefreshControl()
        r.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return r
    }()

    // MARK: Initialization

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
        title = "Small Collection View"
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override
    func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(
            CollectionViewCell.self,
            forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier
        )

        collectionView?.addSubview(refreshControl)
    }

    private
    var disposeBag: DisposeBag?

    @objc
    func refresh() {
        let disposeBag = DisposeBag()
        Observable<Int>.interval(2.0, scheduler: MainScheduler.instance).subscribe { [weak self] _ in
            self?.disposeBag = nil
            self?.refreshControl.endRefreshing()
        }.disposed(by: disposeBag)
        self.disposeBag = disposeBag
    }

    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        refreshControl.endRefreshing()
    }

    // MARK: UICollectionViewDataSource

    override
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.reuseIdentifier,
            for: indexPath
        )
    }

    override
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        (cell as? CollectionViewCell)?.model = "\(indexPath.item)"
    }

}