import UIKit

final class ViewController: UIViewController {
    private let nameField = UITextField()
    private let roleControl = UISegmentedControl(items: ["Student", "Faculty"])
    private let notificationsSwitch = UISwitch()
    private let exploreButton = UIButton(type: .system)
    private let announcementsButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Campus Companion"
        view.backgroundColor = .systemGroupedBackground
        buildLayout()
    }

    private func buildLayout() {
        let heading = UILabel()
        heading.text = "Your campus,\nall in one place."
        heading.font = .preferredFont(forTextStyle: .largeTitle).bold()
        heading.numberOfLines = 0
        let intro = UILabel()
        intro.text = "Choose your role and explore the latest campus information."
        intro.font = .preferredFont(forTextStyle: .body)
        intro.textColor = .secondaryLabel
        intro.numberOfLines = 0
        nameField.placeholder = "Your name"
        nameField.borderStyle = .roundedRect
        nameField.autocorrectionType = .yes
        roleControl.selectedSegmentIndex = 0
        let notificationRow = UIStackView(arrangedSubviews: [UILabel(), notificationsSwitch])
        (notificationRow.arrangedSubviews[0] as? UILabel)?.text = "Notifications"
        (notificationRow.arrangedSubviews[0] as? UILabel)?.font = .preferredFont(forTextStyle: .body)
        notificationRow.distribution = .equalSpacing
        notificationsSwitch.isOn = true
        configureButton(exploreButton, title: "Explore Campus", filled: true)
        configureButton(announcementsButton, title: "Campus Announcements", filled: false)
        exploreButton.addTarget(self, action: #selector(showWelcome), for: .touchUpInside)
        announcementsButton.addTarget(self, action: #selector(showAnnouncements), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [heading, intro, nameField, roleControl, notificationRow, exploreButton, announcementsButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.setCustomSpacing(32, after: intro)
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            exploreButton.heightAnchor.constraint(equalToConstant: 54),
            announcementsButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }

    private func configureButton(_ button: UIButton, title: String, filled: Bool) {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.cornerStyle = .capsule
        config.baseBackgroundColor = filled ? .systemIndigo : UIColor.systemIndigo.withAlphaComponent(0.12)
        config.baseForegroundColor = filled ? .white : .systemIndigo
        button.configuration = config
    }

    @objc private func showWelcome() {
        let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let studentName = (name?.isEmpty == false) ? name! : "there"
        let role = roleControl.selectedSegmentIndex == 1 ? "Faculty" : "Student"
        let status = notificationsSwitch.isOn ? "on" : "off"
        let detail = DetailViewController()
        detail.welcomeMessage = "Welcome, \(studentName)! (\(role)) Notifications: \(status)."
        navigationController?.pushViewController(detail, animated: true)
    }

    @objc private func showAnnouncements() {
        let list = AnnouncementsViewController(style: .insetGrouped)
        list.onSelectAnnouncement = { [weak self] announcement in
            let detail = DetailViewController()
            detail.announcement = announcement
            self?.navigationController?.pushViewController(detail, animated: true)
        }
        navigationController?.pushViewController(list, animated: true)
    }
}

private extension UIFont {
    func bold() -> UIFont { UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold) ?? fontDescriptor, size: pointSize) }
}
