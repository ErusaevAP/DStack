//
//  Example1ViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/2/17.
//

import DStack

final
class Example1ViewController: UITableViewController {

    override
    func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
    }

    override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    override
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "TabsViewController + HeaderView"
        case 1:
            cell.textLabel?.text = "TabsViewController"
        default:
            break
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            show(TabsWithHeaderViewController(), sender: nil)
        case 1:
            show(TabsViewController(), sender: nil)
        default:
            break
        }
    }

    init() {
        super.init(style: .plain)
        title = "Example 1"
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
