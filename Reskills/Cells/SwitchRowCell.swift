import UIKit

enum Mode {
    case date
    case time
}

final class SwitchRowCell: UITableViewCell {
    static let identifier = "SwitchRowCell"
    
    private var mode: Mode = .date
    
    let headerStackView = UIStackView()
    let iconView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let toggle = UISwitch()
    let containerView = UIView()
    private let separator = UIView()
    private let dateTimePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.locale = Locale(identifier: "en_GB")
        return dp
    }()
    
    var selectedDate: Date = Date()
    var selectedTime: Date = Date()
    var onToggleChanged: ((Bool, Date) -> Void)?
    var onDateTimeChanged: ((Date) -> Void)?
    
    var dateTimePickerHeight: NSLayoutConstraint?
    
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
        
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .secondaryLabel
        iconView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.textColor = .label
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .systemBlue
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        subtitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        headerStackView.axis = .vertical
        headerStackView.distribution = .fill
        headerStackView.alignment = .fill
        headerStackView.spacing = 2
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(subtitleLabel)
        
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        
        dateTimePicker.addTarget(self, action: #selector(dateTimeChanged(_:)), for: .valueChanged)
        
        containerView.addSubview(iconView)
        containerView.addSubview(headerStackView)
        containerView.addSubview(toggle)
        containerView.addSubview(separator)
        
        contentView.addSubview(containerView)
        contentView.addSubview(dateTimePicker)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconView.widthAnchor.constraint(equalToConstant: 22),
            iconView.heightAnchor.constraint(equalToConstant: 22),
            iconView.centerYAnchor.constraint(equalTo: headerStackView.centerYAnchor),
            
            headerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            headerStackView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            headerStackView.trailingAnchor.constraint(lessThanOrEqualTo: toggle.leadingAnchor, constant: -24),
            headerStackView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -12),
            
            toggle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            toggle.centerYAnchor.constraint(equalTo: headerStackView.centerYAnchor),
            
            separator.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            separator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            separator.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 12),
            separator.heightAnchor.constraint(equalToConstant: 0.7),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: dateTimePicker.topAnchor),
            
            dateTimePicker.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            dateTimePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateTimePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateTimePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        dateTimePickerHeight = dateTimePicker.heightAnchor.constraint(equalToConstant: 0)
        dateTimePickerHeight?.isActive = true
    }
    
    func configure(icon systemName: String, title: String, isOn: Bool, mode: Mode, selectedDate: Date) {
        self.iconView.image = UIImage(systemName: systemName)
        self.titleLabel.text = title
        self.toggle.isOn = isOn
        
        self.mode = mode
        self.subtitleLabel.isHidden = !isOn
        dateTimePicker.date = roundedUpToHour(Date())
        
        switch mode {
        case .date:
            self.selectedDate = roundedUpToHour(selectedDate)
            dateTimePicker.datePickerMode = .date
            dateTimePicker.preferredDatePickerStyle = .inline
            subtitleLabel.text = isOn ? formattedSubtitle(for: self.selectedDate , mode: self.mode) : nil
        case .time:
            self.selectedTime = roundedUpToHour(selectedDate)
            dateTimePicker.datePickerMode = .time
            dateTimePicker.preferredDatePickerStyle = .wheels
            subtitleLabel.text = isOn ? formattedSubtitle(for: self.selectedTime , mode: self.mode) : nil
        }
    }
    
    @objc private func toggleChanged(_ sender: UISwitch) {
        let selectedDateTime = combineDateTime(date: self.selectedDate, time: self.selectedTime)
        onToggleChanged?(sender.isOn, selectedDateTime ?? Date())
    }
    
    @objc private func dateTimeChanged(_ sender: UIDatePicker) {
        switch mode {
        case .date:
            self.selectedDate = sender.date
            self.subtitleLabel.text = formattedSubtitle(for: self.selectedDate, mode: self.mode)
        case .time:
            self.selectedTime = sender.date
            self.subtitleLabel.text = formattedSubtitle(for: self.selectedTime, mode: self.mode)
        }
        let selectedDateTime = combineDateTime(date: self.selectedDate, time: self.selectedTime)
        onDateTimeChanged?(selectedDateTime ?? Date())
        self.containerView.layoutIfNeeded()
    }
    
    func setExpanded(_ expanded: Bool) {
        self.dateTimePickerHeight?.isActive = !expanded
        
        let showLine = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 18)
        let hideLine: UIEdgeInsets = UIEdgeInsets(top: 0, left: .greatestFiniteMagnitude, bottom: 0, right: 0)
        separatorInset = expanded ? showLine : hideLine
    }
}

