//
//  ViewController.swift
//  UISearchTokenExample
//
//  Created by Fumiya Tanaka on 2020/03/23.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var hobbySearchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private var hobbies: [Hobby] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hobbySearchBar.searchTextField.allowsDeletingTokens = true
        hobbySearchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setToken(from hobby: Hobby) {
        let token = UISearchToken(icon: UIImage(systemName: "desktopcomputer"), text: hobby.rawValue)
        token.representedObject = hobby
        let searchTextField = hobbySearchBar.searchTextField
        // UISearchTextField.textualRange excludes all UISearchToken.
        searchTextField.replaceTextualPortion(of: searchTextField.textualRange, with: token, at: searchTextField.tokens.count)
    }
    
    private func collectHobbies() -> [Hobby] {
        hobbySearchBar.searchTextField.tokens.compactMap { $0.representedObject as? Hobby }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let hobbies = Hobby.create(from: searchText)
        if hobbies.isEmpty {
            return
        }
        for hobby in hobbies {
            setToken(from: hobby)
        }
        self.hobbies = hobbies.map { $0 }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hobbies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = hobbies[indexPath.row].rawValue
        return cell
    }
}
