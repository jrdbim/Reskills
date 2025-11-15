//
//  AddTaskViewController.swift
//  Reskills
//
//  Created by Jiradet Amornpimonkul on 11/6/25.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var titleLabel: UILabel {
        let label = UILabel()
        label.text = "New Task"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        return label
    }
    
    private var isDateOn = false
    private var isTimeOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = titleLabel
        
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: TextFieldCell.identifier)
        tableView.register(SwitchRowCell.self, forCellReuseIdentifier: SwitchRowCell.identifier)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return nil
        case 1: return "Date & Time"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return setSectionHeader(title: "Date & Time")
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.identifier, for: indexPath) as? TextFieldCell else {
                return UITableViewCell()
            }
            titleSection(cell: cell, indexPath: indexPath)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchRowCell.identifier, for: indexPath) as? SwitchRowCell else {
                return UITableViewCell()
            }
            dateTimeSection(cell: cell, indexPath: indexPath)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: .greatestFiniteMagnitude, bottom: 0, right: 0)
            if isDateOn {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 18)
            }
        }
    }
    
    private func setSectionHeader(title: String) -> UIView {
        let containerView = UIView()
        let label = UILabel()
        label.text = title
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
        return containerView
    }
    
    private func dateTimeSection(cell: SwitchRowCell, indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            cell.configure(icon: "calendar", title: "Date", isOn: isDateOn, showsSeparator: true)
            cell.setExpanded(isDateOn, animated: true)
            cell.onToggleChanged = { [weak self] isOn in
                guard let self = self else { return }
                self.isDateOn = isOn
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
            }
        case 1:
            cell.configure(icon: "clock", title: "Time", isOn: false)
        default:
            break
        }
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
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 18)
        }
    }
    
}
