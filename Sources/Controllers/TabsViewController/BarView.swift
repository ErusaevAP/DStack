//
//  BarView.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/21/17.
//
//

import RxCocoa
import RxSwift
import UIKit

// MARK: -

public
protocol TabsBar: class {

    var tappedOnTab: ((Int) -> Void)? { get set }

    var selectedTabIndex: Int { get set }

    var titles: [String] { get set }

    var height: CGFloat { get }

}

// MARK: -

open
class TabsBarView: UIView, TabsBar {

    // MARK: Properties

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

            buttons = titles.enumerated().flatMap { obj -> UIButton in
                let bt = UIButton()
                bt.setTitle(obj.element, for: .normal)
                bt.rx.controlEvent(.touchUpInside).subscribe { [weak self] _ in
                    self?.tappedOnTab?(obj.offset)
                    self?.selectedButton = bt
                }.disposed(by: disposeBag)
                bt.setTitleColor(buttonTitleColor, for: .normal)
                bt.setTitleColor(selectedButtonTitleColor, for: .selected)
                bt.titleLabel?.font = titleFont
                bt.translatesAutoresizingMaskIntoConstraints = false
                return bt
            }
        }
    }

    open
    var height: CGFloat {
        return 44
    }

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

    private
    var selectorView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()

    private lazy
    var separatorView: UIView = {
        let v = UIView()
        v.backgroundColor = self.separatorLineColor
        return v
    }()

    private
    var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.clipsToBounds = false
        s.showsHorizontalScrollIndicator = false
        return s
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

    // MARK: Initialization

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

    // MARK: Layout

    open
    override func layoutSubviews() {
        super.layoutSubviews()

        updateSelectorConstraints()
    }

    // MARK: Private Methods

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
