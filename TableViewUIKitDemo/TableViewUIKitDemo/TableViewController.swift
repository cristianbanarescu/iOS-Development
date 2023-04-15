//
//  TableViewController.swift
//  TableViewUIKitDemo
//
//  Created by Cristian Banarescu on 15.04.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    private let cellIdentifier: String = "CustomTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.label.text = "Hello World!"
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let actions: [UIContextualAction] = [
            UIContextualAction(style: .normal, title: "Insert", handler: { _, _, _ in
                print("Insert tapped")
            }),
        ]
        
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let actions: [UIContextualAction] = [
            UIContextualAction(style: .destructive, title: "Delete", handler: { _, _, _ in
                print("Delete tapped")
            })
        ]
        
        return UISwipeActionsConfiguration(actions: actions)
    }
}
