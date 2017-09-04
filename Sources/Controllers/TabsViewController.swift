//
//  TabsViewController.swift
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
protocol ContentDeferredLoading: class {

    var contentLoaded: ((UIViewController) -> Void)? { get set }

}

// MARK: -

open
class TabsViewController<HeaderView: UIView>:
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

    private
    func configureSelectedTab() {
        if viewControllers.isEmpty { return }
        let indexPath = IndexPath(item: selectedTabIndex, section: 0)
        containerView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)

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

    private(set)
    var selectedViewController: UIViewController? {
        didSet {
            var flexibleHeader: FlexibleHeader? = headerView as? FlexibleHeader
            var parenVC: UIViewController? = self

            while parenVC != nil {
                if
                    let topTabsViewController = parenVC as? TabsViewController,
                    let header = topTabsViewController.headerView as? FlexibleHeader
                {
                    flexibleHeader = header
                }
                parenVC = parenVC?.parent
            }

            if let deferredController = selectedViewController as? ContentDeferredLoading {
                deferredController.contentLoaded = { [weak self, weak flexibleHeader] ctrl in
                    if let scrollViewProvider = ctrl as? ScrollViewProvider {
                        self?.connectScrollView(scrollViewProvider.scrollView, flexibleHeader: flexibleHeader)
                    }
                }
            } else if let scrollViewProvider = selectedViewController as? ScrollViewProvider {
                connectScrollView(scrollViewProvider.scrollView, flexibleHeader: flexibleHeader)
            }
        }
    }

    open
    var viewControllers: [UIViewController] {
        didSet {
            if isViewLoaded {
                tabsBar?.titles = viewControllers.flatMap { $0.title }.flatMap { $0 }
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
        guard let cell = (cell as? ContainerCell), let controller = cell.model else { return }
        controller.willMove(toParentViewController: nil)
        cell.model = nil
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
        disposeBag = DisposeBag()
        scrollView.rx.willBeginDragging.subscribe { [weak flexibleHeader, weak scrollView] _ in
            flexibleHeader?.willBeginDragging(scrollOffset: scrollView?.contentOffset ?? .zero)
        }.addDisposableTo(disposeBag)

        scrollView.rx.didEndDragging.subscribe { [weak flexibleHeader, weak scrollView] _ in
            let velocity = scrollView?.panGestureRecognizer.translation(in: scrollView?.superview)
            flexibleHeader?.didEndDragging(velocity: velocity ?? .zero)
        }.addDisposableTo(disposeBag)

        scrollView.rx.contentOffset.skip(1).subscribe { [weak flexibleHeader] in
            guard let scrollOffset = $0.element else { return }
            flexibleHeader?.scrollOffset = scrollOffset
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
        tabsBar?.selectedTabIndex = selectedTabIndex
        if let headerView = headerView {
            headerView
                .add(inRootView: view)
                .setHeightAnchor(equalTo: headerView.heightAnchor)
                .setTopAnchor(equalTo: topLayoutGuide.bottomAnchor)
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
