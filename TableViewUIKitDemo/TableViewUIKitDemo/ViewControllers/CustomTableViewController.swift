//
//  CustomTableViewController.swift
//  TableViewUIKitDemo
//
//  Created by Cristian Banarescu on 15.04.2023.
//

import UIKit

class CustomTableViewController: UIViewController {
    
    private let cellIdentifier: String = "CustomTableViewCell"

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension CustomTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.label.text = "Hello World!"
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CustomTableViewController: UITableViewDelegate {
    func tableView(
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
    
    func tableView(
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did tap row \(indexPath.row)")
    }
}
