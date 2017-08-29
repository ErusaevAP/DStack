//
//  TabsViewController.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/17/17.
//
//

import RxSwift
import RxCocoa
import DStack
import UIKit

public
protocol ContentDeferredLoading: class {

    var contentLoaded: ((UIViewController) -> Void)? { get set }

}

open
class TabsViewController<HeaderView: UIView>:
    UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    ScrollViewProvider {

    // MARK: Properties

    public
    var scrollView: UIScrollView? {
        return (viewControllers[selectedTabIndex] as? ScrollViewProvider)?.scrollView
    }

    public
    var didSetCurrentTab: ((UIViewController) -> Void)?

    private
    var disposeBag = DisposeBag()

    private
    var topInset: CGFloat {
        return tabsBarView?.frame.height ?? 0
    }

    public
    var selectedTabIndex: Int = 0 {
        didSet {
            guard selectedTabIndex != oldValue else { return }
            let indexPath = IndexPath(item: selectedTabIndex, section: 0)
            containerView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            tabsBar?.selectedTabIndex = selectedTabIndex

            didSetCurrentTab?(viewControllers[selectedTabIndex])
        }
    }

    public
    let headerView: HeaderView?

    private(set)
    var tabsBarView: UIView?

    public
    var tabsBar: TabsBar? {
        return tabsBarView as? TabsBar
    }

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
    var viewControllers: [UIViewController] {
        didSet {
            if isViewLoaded {
                tabsBar?.titles = viewControllers.flatMap { $0.title }.flatMap { $0 }
                containerView.reloadData()
            }
        }
    }

    // MARK: Initialization

    public
    init(headerView: HeaderView? = nil, viewControllers: [UIViewController]) {
        self.headerView = headerView
        self.viewControllers = viewControllers

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
        tabsBarView?.layoutSubviews()
    }

    open override
    func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flowLayout.invalidateLayout()

        // TODO: live hack will fix in the next comite
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { [weak self] _ in
            self?.tabsBarView?.layoutSubviews()
        }
    }

    // MARK: UICollectionViewDataSource

    public
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            let selectedTabIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            tabsBar?.selectedTabIndex = selectedTabIndex
            didSetCurrentTab?(viewControllers[selectedTabIndex])
        }
    }

    public
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let selectedTabIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        tabsBar?.selectedTabIndex = selectedTabIndex
        didSetCurrentTab?(viewControllers[selectedTabIndex])
    }

    public
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
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
        let controller = viewControllers[indexPath.item]
        addChildViewController(controller)
        (cell as? ContainerCell)?.model = controller
        controller.didMove(toParentViewController: self)

        var flexibleHeader: FlexibleHeader? = headerView as? FlexibleHeader
        var parenVC: UIViewController? = controller

        while parenVC != nil {
            if
                let topTabsViewController = parenVC as? TabsViewController,
                let header = topTabsViewController.headerView as? FlexibleHeader
            {
                flexibleHeader = header
            }
            parenVC = parenVC?.parent
        }

        if let deferredController = controller as? ContentDeferredLoading {
            deferredController.contentLoaded = { [weak self, weak flexibleHeader] ctrl in
                if let scrollViewProvider = ctrl as? ScrollViewProvider {
                    self?.connectScrollView(scrollViewProvider.scrollView, flexibleHeader: flexibleHeader)
                }
            }
        } else if let scrollViewProvider = controller as? ScrollViewProvider {
            connectScrollView(scrollViewProvider.scrollView, flexibleHeader: flexibleHeader)
        }
    }

    public
    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let controller = viewControllers[indexPath.item]
        (controller as? ContentDeferredLoading)?.contentLoaded = nil
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

    // MARK: Public Methods

    open
    func buildTabsBarView() -> UIView? {
        assertionFailure("This method should be overridden")
        return nil
    }

    // MARK: Private Methods

    private
    func connectScrollView(_ scrollView: UIScrollView?, flexibleHeader: FlexibleHeader?) {
        guard let scrollView = scrollView, let flexibleHeader = flexibleHeader  else { return }

        scrollView.rx.willBeginDragging.subscribe { [unowned flexibleHeader, unowned scrollView] _ in
            flexibleHeader.willBeginDragging(scrollOffset: scrollView.contentOffset)
        }.addDisposableTo(disposeBag)

        scrollView.rx.didEndDragging.subscribe { [unowned flexibleHeader, unowned scrollView] _ in
            let velocity = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
            flexibleHeader.didEndDragging(velocity: velocity)
        }.addDisposableTo(disposeBag)

        scrollView.rx.contentOffset.skip(1).subscribe { [unowned flexibleHeader, unowned scrollView] in
            guard let scrollOffset = $0.element else { return }
            flexibleHeader.scrollOffset = scrollOffset
        }.addDisposableTo(disposeBag)
    }

    private
    func configureLayout() {
        tabsBarView = buildTabsBarView()
        assert(tabsBar != nil, "Invalid tab bar view")

        tabsBar?.tappedOnTab = { [weak self] in
            self?.selectedTabIndex = $0
        }
        tabsBar?.titles = viewControllers.flatMap { $0.title }.flatMap { $0 }

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
            tabsBarView?
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
            tabsBarView?
                .add(inRootView: view)
                .setSize(height: 44)
                .setTopAnchor(anchor: topLayoutGuide.bottomAnchor)
                .setLeftAnchor(anchor: view.leftAnchor)
                .setRightAnchor(anchor: view.rightAnchor)
        }
    }

}
