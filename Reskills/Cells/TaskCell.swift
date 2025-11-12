//
//  TaskCell.swift
//  Reskills
//
//  Created by Jiradet Amornpimonkul on 10/29/25.
//

import UIKit

final class TaskCell: UITableViewCell {
    
    static let identifier = "TaskCell"
    
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
        
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
        
        subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .label
        subtitleLabel.numberOfLines = 0
        
        textStack.axis = .vertical
        textStack.distribution = .fill
        textStack.alignment = .fill
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)
        
        container.axis = .horizontal
        container.alignment = .center
        container.spacing = 12
        container.distribution = .fill
        container.addArrangedSubview(statusImageView)
        container.addArrangedSubview(textStack)
        
        contentView.addSubview(container)
    }
    
    private func setupLayout() {
        container.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            statusImageView.widthAnchor.constraint(equalToConstant: 24),
            statusImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(title: String, subtitle: String?, isCompleted: Bool) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        let symbolName = isCompleted ? "checkmark.circle" : "circle"
        statusImageView.image = UIImage(systemName: symbolName)
        statusImageView.tintColor = isCompleted ? .green : .tertiaryLabel
    }
}
