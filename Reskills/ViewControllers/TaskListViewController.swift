//
//  TaskListViewController.swift
//  Reskills
//
//  Created by Jiradet Amornpimonkul on 10/28/25.
//

import UIKit

class TaskListViewController: UIViewController {
    
    private let testLabel = UILabel()
    private let tasksTableView = UITableView()
    private var tasks: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Tasks"
        navigationItem.largeTitleDisplayMode = .always
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButton))
        navigationItem.rightBarButtonItems = [addButton, searchButton]
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseID)
        tasksTableView.separatorStyle = .none
        view.addSubview(tasksTableView)

        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: view.topAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    @objc private func addTask() {
        
    }
    
    @objc private func searchButton() {
        
    }
}

extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell {
            
            return cell
        }
        return UITableViewCell()
    }
}

extension TaskListViewController: UITableViewDelegate {
    
}

