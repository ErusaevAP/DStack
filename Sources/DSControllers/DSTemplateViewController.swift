//
//  DSTemplateViewController.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/16/17.
//
//

open
class DSTemplateViewController<View: UIView>: UIViewController {

    public
    let contentView: View

    public
    init(contentView: View? = nil) {
        self.contentView = contentView ?? View()
        super.init(nibName: nil, bundle: nil)
    }

    public required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override
    func viewDidLoad() {
        super.viewDidLoad()

        contentView
            .add(inRootView: view)
            .fill()
    }

}
