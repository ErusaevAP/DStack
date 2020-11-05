//
//  CollectionViewCell.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/21/17.
//

import DStack

final
class CollectionViewCell: UICollectionViewCell {

    static
    let reuseIdentifier = "CollectionViewCell"

    private
    let label = UILabel()

    var model: String? {
        didSet {
            label.text = model
        }
    }

    override
    init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        label.textAlignment = .center
        label
            .add(inRootView: contentView)
            .fill()
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
