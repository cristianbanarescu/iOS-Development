//
//  ViewController.swift
//  AccessibilityDemo
//
//  Created by Cristian Banarescu on 21.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties

    private var breweries: [Brewery] = []
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Breweries"
        
        setupTableView()
        fetchData()
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breweries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BreweryTableViewCell.identifier, for: indexPath) as? BreweryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: breweries[indexPath.row])
        
        return cell
    }
}

// MARK: - Private methods

private extension ViewController {
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: BreweryTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: BreweryTableViewCell.identifier)
    }
    
    func fetchData() {
        let urlString = "https://api.openbrewerydb.org/breweries"
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {
                return
            }
            do {
                if let url = URL(string: urlString) {
                    let data = try Data(contentsOf: url)
                    self.breweries = try JSONDecoder().decode([Brewery].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Fetching data from the API failed with error: \(error.localizedDescription)")
            }
        }
    }
}

