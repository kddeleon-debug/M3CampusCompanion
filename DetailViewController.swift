import UIKit

final class DetailViewController: UIViewController {
    var announcement: CampusAnnouncement?
    var welcomeMessage: String?

    private let card = UIView()
    private let eyebrowLabel = UILabel()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let priorityLabel = UILabel()
    private let postedByLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        buildLayout()
        if let announcement {
            title = announcement.category
            eyebrowLabel.text = "CAMPUS ANNOUNCEMENT"
            titleLabel.text = announcement.title
            dateLabel.text = "Posted on \(announcement.date)"
            priorityLabel.text = "Priority: \(announcement.priority)"
            priorityLabel.textColor = announcement.priority.lowercased() == "urgent" ? .systemRed : .systemGreen
            postedByLabel.text = "Posted by: \(announcement.postedBy)"
        } else {
            title = "Campus Events"
            eyebrowLabel.text = "WELCOME TO CAMPUS COMPANION"
            titleLabel.text = welcomeMessage ?? "Welcome!"
            dateLabel.text = "Explore campus life, services, and events."
            priorityLabel.isHidden = true
            postedByLabel.isHidden = true
        }
    }

    private func buildLayout() {
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .secondarySystemGroupedBackground
        card.layer.cornerRadius = 22
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.06
        card.layer.shadowRadius = 14
        card.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.addSubview(card)

        let stack = UIStackView(arrangedSubviews: [eyebrowLabel, titleLabel, dateLabel, priorityLabel, postedByLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        card.addSubview(stack)
        eyebrowLabel.font = .preferredFont(forTextStyle: .caption1).bold()
        eyebrowLabel.textColor = .systemIndigo
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle).bold()
        titleLabel.numberOfLines = 0
        dateLabel.font = .preferredFont(forTextStyle: .body)
        dateLabel.textColor = .secondaryLabel
        priorityLabel.font = .preferredFont(forTextStyle: .headline)
        postedByLabel.font = .preferredFont(forTextStyle: .body)
        NSLayoutConstraint.activate([
            card.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            card.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 22),
            stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -22),
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 24),
            stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -24)
        ])
    }
}

private extension UIFont {
    func bold() -> UIFont { UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold) ?? fontDescriptor, size: pointSize) }
}
