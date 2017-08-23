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

    var selectedTab: Int { get set }

    var titles: [String] { get set }

}

// MARK: -

open
class TabsBarView: UIView, TabsBar {

    // MARK: Properties

    open
    var tappedOnTab: ((Int) -> Void)?

    open
    var selectedTab: Int = 0 {
        didSet {
            selectedButton = buttons[selectedTab]
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
                bt.setTitleColor(.black, for: .normal)
                bt.setTitleColor(.red, for: .selected)
                return bt
            }
            stackView.add(arrangedSubviews: buttons)
            selectedTab = min(selectedTab, titles.count - 1)
        }
    }

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
    var indicatorView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()

    private
    var separatorView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
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

    // MARK: Initialization

    private
    var indicatorViewWidthConstraint: NSLayoutConstraint?

    private
    var indicatorViewLeftAlignment: NSLayoutConstraint?

    init() {
        super.init(frame: .zero)

        scrollView
            .add(inRootView: self)
            .fill()

        indicatorView
            .add(inRootView: scrollView)
            .setSize(height: 2)
            .setBottomAlignment()

        indicatorViewWidthConstraint = indicatorView.widthAnchor.constraint(equalToConstant: 0)
        indicatorViewLeftAlignment = indicatorView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0)
        indicatorViewWidthConstraint?.isActive = true
        indicatorViewLeftAlignment?.isActive = true

        stackView = UIStackView()
            .set(axis: .horizontal, spacing: 10)
            .add(inRootView: scrollView)
            .fill()
            .setHeight()

        separatorView
            .add(inRootView: self)
            .setWidth()
            .setSize(height: 1)
            .setBottomAlignment()
    }

    required public
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    open
    override func layoutSubviews() {
        super.layoutSubviews()

        indicatorViewWidthConstraint?.constant = selectedButton?.frame.size.width ?? 0
        indicatorViewLeftAlignment?.constant = selectedButton?.frame.origin.x ?? 0
    }

}
