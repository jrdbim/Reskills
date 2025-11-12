//
//  AddTaskViewController.swift
//  Reskills
//
//  Created by Jiradet Amornpimonkul on 11/6/25.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let titleLable = UILabel()
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIButton.Configuration.plain()
        var updatedConfig = config
        updatedConfig.image = UIImage(systemName: "xmark")
        updatedConfig.baseForegroundColor = .label
        updatedConfig.background.backgroundColor = .secondarySystemBackground
        updatedConfig.cornerStyle = .capsule
        button.configuration = updatedConfig
        button.layer.masksToBounds = true
        return button
    }()
    private let okButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIButton.Configuration.plain()
        var updatedConfig = config
        updatedConfig.image = UIImage(systemName: "checkmark")
        updatedConfig.baseForegroundColor = .label
        updatedConfig.background.backgroundColor = .secondarySystemBackground
        updatedConfig.cornerStyle = .capsule
        button.configuration = updatedConfig
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "New Task"
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done,
                                       target: self,
                                       action: #selector(doneTapped))
        doneItem.tintColor = .quaternaryLabel
        navigationItem.rightBarButtonItem = doneItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(closeTapped))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: TextFieldCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        setupUI()
    }
    
    private func setupUI() {
        NSLayoutConstraint.activate([
            // TableView
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc private func doneTapped() {
        dismiss(animated: true)
    }
    
}

extension AddTaskViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.identifier, for: indexPath) as? TextFieldCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            titleSection(cell: cell, indexPath: indexPath)
        default:
            break
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func titleSection(cell: TextFieldCell, indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            cell.textField.font = .preferredFont(forTextStyle: .largeTitle)
            let placeholder = "Title"
            let attrs: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.placeholderText,
                .font: UIFont.preferredFont(forTextStyle: .body)
            ]
            cell.textField.textContentType = .none
            cell.textField.keyboardType = .default
            cell.textField.returnKeyType = .next
            cell.textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attrs)
        case 1:
            cell.textField.placeholder = "Notes"
            cell.textField.textContentType = .none
            cell.textField.keyboardType = .default
            cell.textField.returnKeyType = .next
            cell.textField.font = .preferredFont(forTextStyle: .body)
        default:
            cell.textField.placeholder = "URL"
            cell.textField.textContentType = .none
            cell.textField.keyboardType = .default
            cell.textField.returnKeyType = .next
            cell.textField.font = .preferredFont(forTextStyle: .body)
        }
        
        if indexPath.row == 0 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: .greatestFiniteMagnitude, bottom: 0, right: 0)
        } else {
            cell.separatorInset = tableView.separatorInset
        }
    }
    
}
