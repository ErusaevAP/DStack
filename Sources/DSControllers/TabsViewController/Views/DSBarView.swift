//
//  BarView.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/21/17.
//
//

import RxCocoa
import RxSwift

public
protocol DSTabsBar: AnyObject {

    var tappedOnTab: ((Int) -> Void)? { get set }

    var selectedTabIndex: Int { get set }

    var titles: [String] { get set }

    var height: CGFloat { get }

}

open
class DSTabsBarView: UIView, DSTabsBar {

    open
    var tappedOnTab: ((Int) -> Void)?

    open
    var selectedTabIndex: Int = 0 {
        didSet {
            if selectedTabIndex < buttons.count, selectedTabIndex >= 0 {
                selectedButton = buttons[selectedTabIndex]
            }
        }
    }

    open
    var titles: [String] = [] {
        didSet {
            disposeBag = DisposeBag()

            buttons = titles.enumerated().compactMap { obj -> UIButton in
                let button = UIButton()
                button.setTitle(obj.element, for: .normal)
                button.rx.controlEvent(.touchUpInside).subscribe { [weak self] _ in
                    self?.tappedOnTab?(obj.offset)
                    self?.selectedButton = button
                }.disposed(by: disposeBag)
                button.setTitleColor(buttonTitleColor, for: .normal)
                button.setTitleColor(selectedButtonTitleColor, for: .selected)
                button.titleLabel?.font = titleFont
                button.translatesAutoresizingMaskIntoConstraints = false
                return button
            }
        }
    }

    open
    var height: CGFloat = 44

    private
    let titleFont: UIFont?

    private
    let buttonTitleColor: UIColor

    private
    let selectedButtonTitleColor: UIColor

    private
    let separatorLineHeight: CGFloat

    private
    let separatorLineColor: UIColor

    private
    let selectorLineHeight: CGFloat

    private
    let selectorLineColor: UIColor

    private
    var disposeBag = DisposeBag()

    private
    var selectedButton: UIButton? {
        didSet {
            oldValue?.isSelected = false
            guard let selectedButton = selectedButton else { return }

            selectedButton.isSelected = true
            layoutIfNeeded()
            updateSelectorConstraints()
            scrollView.scrollRectToVisible(selectedButton.frame, animated: true)
        }
    }

    private
    var stackView = UIStackView()

    private lazy
    var selectorView: UIView = {
        let view = UIView()
        view.backgroundColor = selectorLineColor
        return view
    }()

    private lazy
    var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = separatorLineColor
        return view
    }()

    private
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.clipsToBounds = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    private
    var buttons: [UIButton] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            buttons.forEach { stackView.add(arrangedSubviews: $0) }
        }
    }

    private
    var selectorViewWidthConstraint: NSLayoutConstraint?

    private
    var selectorViewLeftAlignment: NSLayoutConstraint?

    public
    init(
        titleFont: UIFont? = nil,
        buttonTitleColor: UIColor = .black,
        selectedButtonTitleColor: UIColor = .red,
        separatorLineHeight: CGFloat = 1,
        separatorLineColor: UIColor = .gray,
        selectorLineHeight: CGFloat = 2,
        selectorLineColor: UIColor = .red
    ) {
        self.titleFont = titleFont
        self.buttonTitleColor = buttonTitleColor
        self.selectedButtonTitleColor = selectedButtonTitleColor
        self.separatorLineHeight = separatorLineHeight
        self.separatorLineColor = separatorLineColor
        self.selectorLineHeight = selectorLineHeight
        self.selectorLineColor = selectorLineColor
        super.init(frame: .zero)

        configureSubviews()
    }

    public override convenience
    init(frame: CGRect) {
        self.init(titleFont: UIFont.systemFont(ofSize: 14))
    }

    required public
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open
    override func layoutSubviews() {
        super.layoutSubviews()

        updateSelectorConstraints()
    }

    private
    func configureSubviews() {
        clipsToBounds = false
        scrollView
            .add(inRootView: self)
            .setCenter()
            .setTopAlignment()
            .setBottomAlignment()
            .setLeadingAnchor(greaterThanOrEqualTo: leadingAnchor, priority: UILayoutPriority.defaultLow)
            .setTrailingAnchor(greaterThanOrEqualTo: trailingAnchor, priority: UILayoutPriority.defaultLow)

        selectorView
            .add(inRootView: scrollView)
            .setSize(height: selectorLineHeight)
            .setBottomAlignment()

        selectorViewWidthConstraint = selectorView.widthAnchor.constraint(equalToConstant: 0)
        selectorViewLeftAlignment = selectorView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0)
        selectorViewWidthConstraint?.isActive = true
        selectorViewLeftAlignment?.isActive = true

        stackView = UIStackView()
            .set(axis: .horizontal, spacing: 10, alignment: .center, distribution: .fill)
            .add(inRootView: scrollView)
            .setBottomAnchor(equalTo: scrollView.bottomAnchor)
            .setTopAnchor(equalTo: scrollView.topAnchor)
            .setHeightAnchor(equalTo: scrollView.heightAnchor)
            .setWidthAnchor(greaterThanOrEqualTo: scrollView.widthAnchor)
            .setLeadingAnchor(equalTo: scrollView.leadingAnchor)
            .setTrailingAnchor(equalTo: scrollView.trailingAnchor)

        separatorView
            .add(inRootView: self)
            .setLeftAlignment(marge: -10)
            .setRightAlignment(marge: -10)
            .setSize(height: separatorLineHeight)
            .setBottomAlignment()
    }

    private
    func updateSelectorConstraints() {
        selectorViewWidthConstraint?.constant = selectedButton?.frame.size.width ?? 0
        selectorViewLeftAlignment?.constant = selectedButton?.frame.origin.x ?? 0
    }

}
