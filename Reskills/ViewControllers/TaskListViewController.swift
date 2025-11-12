//
//  TaskListViewController.swift
//  Reskills
//
//  Created by Jiradet Amornpimonkul on 10/28/25.
//

import UIKit

class TaskListViewController: UIViewController {
    
    private let tasksTableView = UITableView()
    private var tasks: [TaskModel] = []
    
    private let emptyStateView: UIStackView = {
        let title = UILabel()
        title.text = "No Tasks"
        title.font = .preferredFont(forTextStyle: .largeTitle)
        title.textAlignment = .center
        title.textColor = .secondaryLabel
        
        let subtitle = UILabel()
        subtitle.text = "Tap + to add your First Task"
        subtitle.font = .preferredFont(forTextStyle: .body)
        subtitle.textAlignment = .center
        subtitle.textColor = .secondaryLabel
        
        let stackView = UIStackView(arrangedSubviews: [title, subtitle])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Tasks"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButton))
        navigationItem.rightBarButtonItems = [addButton, searchButton]
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.estimatedRowHeight = 72
        tasksTableView.rowHeight = UITableView.automaticDimension
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        tasksTableView.separatorStyle = .none
        view.addSubview(tasksTableView)
        view.addSubview(emptyStateView)

        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: view.topAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        tasks = [
            TaskModel(title: "Buy groceries and some other very long title to test wrapping",
                      notes: "Milk, eggs, bread, and fruits",
                      isCompleted: false),
            TaskModel(title: "Read a book",
                      notes: "At least 20 pages today",
                      isCompleted: true),
            TaskModel(title: "Workout",
                      notes: nil,
                      isCompleted: false)
        ]
        
        checkEmptyState()
        tasksTableView.reloadData()
    }
    
    private func checkEmptyState() {
        let isEmpty =  tasks.isEmpty
        tasksTableView.isHidden = isEmpty
        emptyStateView.isHidden = !isEmpty
    }
    
    @objc private func addTask() {
        let vc = AddTaskViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .pageSheet
        self.present(nav, animated: true)
    }
    
    @objc private func searchButton() {
        
    }
}

extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        let item = tasks[indexPath.row]
        cell.configure(title: item.title, subtitle: item.notes, isCompleted: item.isCompleted)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            checkEmptyState()
        }
    }
    
}

extension TaskListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Toggle completion state
        self.tasks[indexPath.row].isCompleted.toggle()
        // Haptic feedback
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        // Reload only this row to reflect the new state
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

