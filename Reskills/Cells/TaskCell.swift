//
//  TaskCell.swift
//  Reskills
//
//  Created by Jiradet Amornpimonkul on 10/29/25.
//

import UIKit

final class TaskCell: UITableViewCell {
    
    static let reuseID = "TaskCell"
    
    private let statusImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let container = UIStackView()
    private let textStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        statusImageView.contentMode = .scaleAspectFit
        statusImageView.tintColor = .tertiaryLabel
        
        titleLabel.text = "Test title"
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
        
        subtitleLabel.text = "Test subtitle"
        subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .label
        subtitleLabel.numberOfLines = 0
        
        textStack.axis = .vertical
        textStack.distribution = .fill
        textStack.alignment = .fill
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)
        
        contentView.addSubview(textStack)
    }
    
    private func setupLayout() {
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
