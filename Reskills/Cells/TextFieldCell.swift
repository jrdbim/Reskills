//
//  TextFieldCell.swift
//  Reskills
//
//  Created by Jiradet Amornpimonkul on 11/12/25.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    static let identifier = "TextFieldCell"
    let textField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            textField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) { super.init(coder: coder) }

}
