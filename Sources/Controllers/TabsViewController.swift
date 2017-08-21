//
//  TabsViewController.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/17/17.
//
//

import RxSwift
import RxCocoa
import UIKit

open
class TabsViewController<HeaderView: UIView>:
    UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {

    // MARK: Properties

    private
    var disposeBag = DisposeBag()

    private
    var topInset: CGFloat {
        return bar.frame.height
    }

    public
    let headerView: HeaderView?

    public
    let bar = BarView()

    private
    let flowLayout: UICollectionViewFlowLayout = {
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .horizontal
        return l
    }()

    private lazy
    var containerView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        v.backgroundColor = .lightGray
        v.isPagingEnabled = true
        v.dataSource = self
        v.delegate = self
        v.showsHorizontalScrollIndicator = false
        v.backgroundColor = .white
        v.register(ContainerCell.self, forCellWithReuseIdentifier: ContainerCell.reuseIdentifier)
        return v
    }()

    open
    var viewControlles: [UIViewController] {
        didSet {
            if isViewLoaded {
                bar.model = viewControlles.flatMap { $0.title }.flatMap { $0 }
                containerView.reloadData()
            }
        }
    }

    // MARK: Initialization

    public
    init(headerView: HeaderView? = nil, viewControlles: [UIViewController]) {
        self.headerView = headerView
        self.viewControlles = viewControlles
        self.bar.model = viewControlles.flatMap { $0.title }.flatMap { $0 }
        super.init(nibName: nil, bundle: nil)
    }

    required public
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    open override
    func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        configureLayout()
    }

    open override
    func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        flowLayout.invalidateLayout()
    }

    open override
    func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flowLayout.invalidateLayout()
    }

    // MARK: UICollectionViewDataSource

    public
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControlles.count
    }

    public
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(
            withReuseIdentifier: ContainerCell.reuseIdentifier,
            for: indexPath
        )
    }

    public
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let controller = viewControlles[indexPath.item]
        addChildViewController(controller)
        (cell as? ContainerCell)?.model = controller
        controller.didMove(toParentViewController: self)

        if
            let scrollView = (controller as? ScrollViewProvider)?.scrollView,
            let headerView = headerView as? FlexibleHeader
        {
            scrollView.rx.willBeginDragging.subscribe { [unowned headerView, unowned scrollView] _ in
                headerView.willBeginDragging(scrollOffset: scrollView.contentOffset)
            }.addDisposableTo(disposeBag)

            scrollView.rx.didEndDragging.subscribe { [unowned headerView, unowned scrollView] _ in
                let velocity = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
                headerView.didEndDragging(velocity: velocity)
            }.addDisposableTo(disposeBag)

            scrollView.rx.contentOffset.skip(1).subscribe { [unowned headerView, unowned scrollView] in
                guard let scrollOffset = $0.element else { return }
                headerView.scrollOffset = scrollOffset
            }.addDisposableTo(disposeBag)
        }
    }

    public
    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let controller = viewControlles[indexPath.item]
        controller.willMove(toParentViewController: nil)
        (cell as? ContainerCell)?.model = nil
        controller.removeFromParentViewController()
    }

    public
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.frame.size.width,
            height: collectionView.frame.height - topInset
        )
    }

    public
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }

    public
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: topInset,
            left: 0,
            bottom: 0,
            right: 0
        )
    }

    // MARK: Private Methods

    private
    func configureLayout() {
        if let headerView = headerView {
            headerView
                .add(inRootView: view)
                .setHeightAnchor(anchor: headerView.heightAnchor)
                .setTopAnchor(anchor: topLayoutGuide.bottomAnchor)
                .setLeftAnchor(anchor: view.leftAnchor)
                .setRightAnchor(anchor: view.rightAnchor)
            containerView
                .add(inRootView: view)
                .setTopAnchor(anchor: headerView.bottomAnchor)
                .setLeftAnchor(anchor: view.leftAnchor)
                .setRightAnchor(anchor: view.rightAnchor)
                .setBottomAnchor(anchor: bottomLayoutGuide.topAnchor)
            bar
                .add(inRootView: view)
                .setSize(height: 44)
                .setTopAnchor(anchor: headerView.bottomAnchor)
                .setLeftAnchor(anchor: view.leftAnchor)
                .setRightAnchor(anchor: view.rightAnchor)
        } else {
            containerView
                .add(inRootView: view)
                .setTopAnchor(anchor: topLayoutGuide.bottomAnchor)
                .setLeftAnchor(anchor: view.leftAnchor)
                .setRightAnchor(anchor: view.rightAnchor)
                .setBottomAnchor(anchor: bottomLayoutGuide.topAnchor)
            bar
                .add(inRootView: view)
                .setSize(height: 44)
                .setTopAnchor(anchor: topLayoutGuide.bottomAnchor)
                .setLeftAnchor(anchor: view.leftAnchor)
                .setRightAnchor(anchor: view.rightAnchor)
        }
    }

}
