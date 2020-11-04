//
//  CollectionViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/21/17.
//

import RxCocoa
import RxSwift
import UIKit

class CollectionViewController: UICollectionViewController {

    private lazy
    var refreshControl: UIRefreshControl = {
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return ref
    }()

    // MARK: Initialization

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
        title = "Collection View"
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
        let interval = DispatchTimeInterval.seconds(2)
        Observable<Int>.interval(interval, scheduler: MainScheduler.instance).subscribe { [weak self] _ in
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
        100
    }

    override
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(
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
