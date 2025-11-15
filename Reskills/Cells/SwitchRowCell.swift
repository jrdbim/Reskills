import UIKit

final class SwitchRowCell: UITableViewCell {
    
    static let identifier = "SwitchRowCell"
    let iconView = UIImageView()
    let titleLabel = UILabel()
    let toggle = UISwitch()
    private let separator = UIView()
    private let expandedContainer = UIView()
    private let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.preferredDatePickerStyle = .inline
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    private var collapsedExpandedHeightConstraint: NSLayoutConstraint!
    
    var onToggleChanged: ((Bool) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupLayout()
    }
    
    
    private func setupView() {
        selectionStyle = .none
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .secondaryLabel
        iconView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.textColor = .label
        
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        separator.isHidden = true
        
        expandedContainer.translatesAutoresizingMaskIntoConstraints = false
        expandedContainer.isHidden = true
        
        datePicker.isHidden = true

        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(toggle)
        contentView.addSubview(separator)
        contentView.addSubview(expandedContainer)
        expandedContainer.addSubview(datePicker)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            iconView.widthAnchor.constraint(equalToConstant: 22),
            iconView.heightAnchor.constraint(equalToConstant: 22),

            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: toggle.leadingAnchor, constant: -12),

            toggle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            toggle.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            
            // Separator under header
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            separator.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 16),
            separator.heightAnchor.constraint(equalToConstant: 0.7),

            // Expanded container under separator
            expandedContainer.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 0),
            expandedContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            expandedContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            expandedContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

            // Date picker fills expanded container
            datePicker.topAnchor.constraint(equalTo: expandedContainer.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: expandedContainer.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: expandedContainer.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: expandedContainer.bottomAnchor),
        ])
        
        // Collapse expanded container by default so the cell doesn't reserve space when hidden
        collapsedExpandedHeightConstraint = expandedContainer.heightAnchor.constraint(equalToConstant: 0)
        collapsedExpandedHeightConstraint.isActive = true
    }
    
    func configure(icon systemName: String, title: String, isOn: Bool, showsSeparator: Bool = false) {
        iconView.image = UIImage(systemName: systemName)
        titleLabel.text = title
        toggle.isOn = isOn
        separator.isHidden = !showsSeparator
    }
    
    @objc private func toggleChanged(_ sender: UISwitch) {
        onToggleChanged?(sender.isOn)
    }
    
    func setExpanded(_ expanded: Bool, animated: Bool = false) {
        let changes = {
            self.collapsedExpandedHeightConstraint.isActive = !expanded
            self.expandedContainer.isHidden = !expanded
            self.datePicker.isHidden = !expanded
            self.layoutIfNeeded()
        }
        if animated {
            UIView.animate(withDuration: 0.25) {
                changes()
            }
        } else {
            changes()
        }
    }
}
