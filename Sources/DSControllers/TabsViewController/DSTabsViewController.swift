//
//  DSTabsViewController.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/17/17.
//
//

import RxSwift
import RxCocoa

// swiftlint:disable type_body_length

// MARK: -

public
protocol DSContentDeferredLoading: class {

    var contentLoaded: ((UIViewController) -> Void)? { get set }

}

// MARK: -

open
class DSTabsViewController<HeaderView: UIView>:
    UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {

    // MARK: Properties

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
            guard
                selectedTabIndex < viewControllers.count,
                selectedTabIndex >= 0
            else {
                return
            }
            configureSelectedTab()
        }
    }

    open
    var isAnimatedScroolWhenTabSelected: Bool {
        return false
    }

    private
    func configureSelectedTab() {
        if viewControllers.isEmpty { return }
        let indexPath = IndexPath(item: selectedTabIndex, section: 0)
        containerView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: isAnimatedScroolWhenTabSelected)

        tabsBar?.selectedTabIndex = selectedTabIndex
        let ctrl = viewControllers[selectedTabIndex]
        selectedViewController = ctrl
        didSetCurrentTab?(ctrl)
    }

    public
    let headerView: HeaderView?

    private(set)
    var tabsBarView: UIView?

    public
    var tabsBar: DSTabsBar? {
        return tabsBarView as? DSTabsBar
    }

    private
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()

    private lazy
    var containerView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.backgroundColor = .clear
        view.isPagingEnabled = true
        view.dataSource = self
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.register(DSContainerCell.self, forCellWithReuseIdentifier: DSContainerCell.reuseIdentifier)
        return view
    }()

    private(set)
    var selectedViewController: UIViewController? {
        didSet {
            var flexibleHeader: DSFlexibleHeader? = headerView as? DSFlexibleHeader
            var parenVC: UIViewController? = self

            while parenVC != nil {
                if
                    let topTabsViewController = parenVC as? DSTabsViewController,
                    let header = topTabsViewController.headerView as? DSFlexibleHeader
                {
                    flexibleHeader = header
                }
                parenVC = parenVC?.parent
            }

            if let deferredController = selectedViewController as? DSContentDeferredLoading {
                deferredController.contentLoaded = { [weak self, weak flexibleHeader] ctrl in
                    if let scrollViewProvider = ctrl as? DSScrollViewProvider {
                        self?.connectScrollView(scrollViewProvider.dsScrollView, flexibleHeader: flexibleHeader)
                    }
                }
            } else if let scrollViewProvider = selectedViewController as? DSScrollViewProvider {
                connectScrollView(scrollViewProvider.dsScrollView, flexibleHeader: flexibleHeader)
            }
        }
    }

    open
    var viewControllers: [UIViewController] {
        didSet {
            if isViewLoaded {
                tabsBar?.titles = viewControllers.compactMap { $0.title }
                containerView.reloadData()
                if let selectedViewController = selectedViewController {
                    if let currentIndex = viewControllers.index(of: selectedViewController) {
                        selectedTabIndex = currentIndex
                    } else {
                        selectedTabIndex = min(tabsBar?.selectedTabIndex ?? 0, viewControllers.count - 1)
                    }
                } else {
                    selectedTabIndex = 0
                }
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
    }

    // MARK: UICollectionViewDataSource

    public
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            selectedTabIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        }
    }

    public
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        selectedTabIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
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
            withReuseIdentifier: DSContainerCell.reuseIdentifier,
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
        addChild(controller)
        (cell as? DSContainerCell)?.model = controller
        controller.didMove(toParent: self)

        if selectedViewController == nil {
            selectedViewController = controller
        }
    }

    public
    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let cell = (cell as? DSContainerCell), let controller = cell.model else { return }
        controller.willMove(toParent: nil)
        cell.model = nil
        controller.removeFromParent()
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
        return DSTabsBarView()
    }

    // MARK: Private Methods

    private
    func connectScrollView(_ scrollView: UIScrollView?, flexibleHeader: DSFlexibleHeader?) {
        guard let scrollView = scrollView, let flexibleHeader = flexibleHeader  else { return }
        disposeBag = DisposeBag()
        scrollView.rx.willBeginDragging.subscribe { [weak flexibleHeader, weak scrollView] _ in
            flexibleHeader?.willBeginDragging(scrollOffset: scrollView?.contentOffset ?? .zero)
        }.disposed(by: disposeBag)

        scrollView.rx.didEndDragging.subscribe { [weak flexibleHeader, weak scrollView] _ in
            let velocity = scrollView?.panGestureRecognizer.translation(in: scrollView?.superview)
            flexibleHeader?.didEndDragging(velocity: velocity ?? .zero)
        }.disposed(by: disposeBag)

        scrollView.rx.contentOffset.skip(1).subscribe { [weak flexibleHeader] in
            guard let scrollOffset = $0.element else { return }
            flexibleHeader?.scrollOffset = scrollOffset
        }.disposed(by: disposeBag)
    }

    private
    func configureLayout() {
        tabsBarView = buildTabsBarView()
        assert(tabsBar != nil, "Invalid tab bar view")

        tabsBar?.tappedOnTab = { [weak self] in
            self?.selectedTabIndex = $0
        }
        tabsBar?.titles = viewControllers.compactMap { $0.title }
        tabsBar?.selectedTabIndex = selectedTabIndex
        if let headerView = headerView {
            headerView
                .add(inRootView: view)
                .setHeightAnchor(equalTo: headerView.heightAnchor)
                .setTopAnchor(equalTo: topLayoutGuide.topAnchor)
                .setLeftAnchor(equalTo: view.leftAnchor)
                .setRightAnchor(equalTo: view.rightAnchor)
            containerView
                .add(inRootView: view)
                .setTopAnchor(equalTo: headerView.bottomAnchor)
                .setLeftAnchor(equalTo: view.leftAnchor)
                .setRightAnchor(equalTo: view.rightAnchor)
                .setBottomAnchor(equalTo: bottomLayoutGuide.topAnchor)
            tabsBarView?
                .add(inRootView: view)
                .setSize(height: tabsBar?.height)
                .setTopAnchor(equalTo: headerView.bottomAnchor)
                .setLeftAnchor(equalTo: view.leftAnchor, marge: 5)
                .setRightAnchor(equalTo: view.rightAnchor, marge: 5)
        } else {
            containerView
                .add(inRootView: view)
                .setTopAnchor(equalTo: topLayoutGuide.bottomAnchor)
                .setLeftAnchor(equalTo: view.leftAnchor)
                .setRightAnchor(equalTo: view.rightAnchor)
                .setBottomAnchor(equalTo: bottomLayoutGuide.topAnchor)
            tabsBarView?
                .add(inRootView: view)
                .setSize(height: tabsBar?.height)
                .setTopAnchor(equalTo: topLayoutGuide.bottomAnchor)
                .setLeftAnchor(equalTo: view.leftAnchor, marge: 5)
                .setRightAnchor(equalTo: view.rightAnchor, marge: 5)
        }
    }

}
