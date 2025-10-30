//
//
//  Created by Jiradet Amornpimonkul on 10/27/25.
//


import UIKit

class WelcomeViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        titleLabel.text = "Personal Hub"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.text = "Welcome back! เลือกหมวดที่อยากเริ่มก่อนเลย"
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = .label
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var tasksConfig = UIButton.Configuration.bordered()
        tasksConfig.title = "Tasks"
        tasksConfig.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        let tasksButton = UIButton(configuration: tasksConfig)
        tasksButton.addTarget(self, action: #selector(didTapTasks(_:)), for: .touchUpInside)

        var favConfig = UIButton.Configuration.bordered()
        favConfig.title = "Favorites"
        favConfig.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        let favButton = UIButton(configuration: favConfig)
        favButton.addTarget(self, action: #selector(didTapFav(_:)), for: .touchUpInside)
        
        let buttonsRow = UIStackView(arrangedSubviews: [tasksButton, favButton])
        buttonsRow.axis = .horizontal
        buttonsRow.alignment = .center
        buttonsRow.spacing = 16
        buttonsRow.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, buttonsRow])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: guide.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: guide.trailingAnchor, constant: -8)
        ])
        
    }
    
    @objc private func didTapTasks(_ sender: UIButton) {
        let vc = TaskListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapFav(_ sender: UIButton) {
        // Haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        // Tap animation (press then spring back)
        UIView.animate(withDuration: 0.08, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.12,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0.8,
                           options: .curveEaseOut,
                           animations: {
                sender.transform = .identity
            })
        }

        // Temporary alert
        let alert = UIAlertController(title: "Favorites", message: "Coming soon…", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}
