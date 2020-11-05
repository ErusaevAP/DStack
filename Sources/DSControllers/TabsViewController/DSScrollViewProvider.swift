//
//  DSScrollViewProvider.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/21/17.
//
//

public
protocol DSScrollViewProvider: AnyObject {

    var dsScrollView: UIScrollView? { get }

}

extension UICollectionViewController: DSScrollViewProvider {

    public
    var dsScrollView: UIScrollView? {
        collectionView
    }

}

extension UITableViewController: DSScrollViewProvider {

    public
    var dsScrollView: UIScrollView? {
        tableView
    }

}
