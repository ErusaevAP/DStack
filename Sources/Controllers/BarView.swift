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
            selectedButton = buttons[selectedTabIndex]
        }
    }

    open
    var titles: [String] = [] {
        didSet {
            disposeBag = DisposeBag()
            buttons.forEach { stackView.removeArrangedSubview($0) }
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
                return bt
            }
            stackView.add(arrangedSubviews: buttons)
            selectedTabIndex = min(selectedTabIndex, titles.count - 1)
        }
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
            scrollView.scrollRectToVisible(selectedButton.frame, animated: true)
            layoutSubviews()
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
        s.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        s.showsHorizontalScrollIndicator = false
        return s
    }()

    private
    var buttons: [UIButton] = []

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
        selectorLineHeight: CGFloat = 1,
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

        scrollView
            .add(inRootView: self)
            .fill()

        selectorView
            .add(inRootView: scrollView)
            .setSize(height: selectorLineHeight)
            .setBottomAlignment()

        selectorViewWidthConstraint = selectorView.widthAnchor.constraint(equalToConstant: 0)
        selectorViewLeftAlignment = selectorView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0)
        selectorViewWidthConstraint?.isActive = true
        selectorViewLeftAlignment?.isActive = true

        stackView = UIStackView()
            .set(axis: .horizontal, spacing: 10)
            .set(alignment: .fill, distribution: .fillProportionally)
            .add(inRootView: scrollView)
            .fill()
            .setHeight()

        separatorView
            .add(inRootView: self)
            .setWidth()
            .setSize(height: separatorLineHeight)
            .setBottomAlignment()
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

        if scrollView.contentSize.width != 0, scrollView.contentSize.width <= scrollView.frame.size.width {
            stackView.set(alignment: .fill, distribution: .fillProportionally)
            stackView.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
            stackView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        } else {
            stackView.set(alignment: .fill, distribution: .fill)
            stackView.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = false
            stackView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = false
        }

        selectorViewWidthConstraint?.constant = selectedButton?.frame.size.width ?? 0
        selectorViewLeftAlignment?.constant = selectedButton?.frame.origin.x ?? 0

    }

}
