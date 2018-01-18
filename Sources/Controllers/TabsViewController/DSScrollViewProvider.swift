//
//  DSScrollViewProvider.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/21/17.
//
//

import UIKit

// MARK: -

public
protocol DSScrollViewProvider: class {

    var scrollView: UIScrollView? { get }

}

// MARK: -

extension UICollectionViewController: DSScrollViewProvider {

    public
    var scrollView: UIScrollView? {
        return collectionView
    }

}

// MARK: -

extension UITableViewController: DSScrollViewProvider {

    public
    var scrollView: UIScrollView? {
        return tableView
    }

}
