//
//  ScrollViewProvider.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/21/17.
//
//

import UIKit

// MARK: -

public
protocol ScrollViewProvider: class {

    var scrollView: UIScrollView? { get }

}

// MARK: -

extension UICollectionViewController: ScrollViewProvider {

    public
    var scrollView: UIScrollView? {
        return collectionView
    }

}

// MARK: -

extension UITableViewController: ScrollViewProvider {

    public
    var scrollView: UIScrollView? {
        return tableView
    }

}
