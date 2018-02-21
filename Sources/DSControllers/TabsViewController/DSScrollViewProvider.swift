//
//  DSScrollViewProvider.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/21/17.
//
//

// MARK: -

public
protocol DSScrollViewProvider: class {

    var dsScrollView: UIScrollView? { get }

}

// MARK: -

extension UICollectionViewController: DSScrollViewProvider {

    public
    var dsScrollView: UIScrollView? {
        return collectionView
    }

}

// MARK: -

extension UITableViewController: DSScrollViewProvider {

    public
    var dsScrollView: UIScrollView? {
        return tableView
    }

}
