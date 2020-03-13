//
//  ViewController.swift
//  UITableViewLabelPerformance
//
//  Created by Fumiya Tanaka on 2020/03/14.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }
}

class ViewController: UIViewController {
    
    private var tableView: UITableView = {
        let content = UITableView()
        content.frame = UIScreen.main.bounds
        return content
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // remove content because cell is disappeared.        
//        cell.textLabel?.text = nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? Cell
        var text: String = ""
        for _ in 0...10 {
            let random = UUID().uuidString
            text.append(random)
        }
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.text = text
        return cell!
    }
}
