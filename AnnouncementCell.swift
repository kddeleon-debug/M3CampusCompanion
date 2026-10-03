import UIKit

final class AnnouncementCell: UITableViewCell {
    static let reuseIdentifier = "AnnouncementCell"

    private let categoryIconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let priorityBadge = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildLayout()
    }

    private func buildLayout() {
        selectionStyle = .default
        categoryIconImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryIconImageView.contentMode = .scaleAspectFit
        categoryIconImageView.tintColor = .systemIndigo
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 2
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = .preferredFont(forTextStyle: .subheadline)
        dateLabel.textColor = .secondaryLabel
        priorityBadge.translatesAutoresizingMaskIntoConstraints = false
        priorityBadge.font = .preferredFont(forTextStyle: .caption1).bold()
        priorityBadge.textAlignment = .center
        priorityBadge.layer.cornerRadius = 9
        priorityBadge.clipsToBounds = true

        let textStack = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.spacing = 4
        let row = UIStackView(arrangedSubviews: [categoryIconImageView, textStack, priorityBadge])
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .center
        row.spacing = 12
        contentView.addSubview(row)
        NSLayoutConstraint.activate([
            categoryIconImageView.widthAnchor.constraint(equalToConstant: 32),
            categoryIconImageView.heightAnchor.constraint(equalToConstant: 32),
            priorityBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 58),
            row.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            row.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            row.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            row.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    func configure(with announcement: CampusAnnouncement) {
        titleLabel.text = announcement.title
        dateLabel.text = "\(announcement.category) • \(announcement.date) • \(announcement.postedBy)"
        let isUrgent = announcement.priority.caseInsensitiveCompare("Urgent") == .orderedSame
        categoryIconImageView.image = UIImage(systemName: isUrgent ? "megaphone.fill" : "megaphone")
        categoryIconImageView.tintColor = isUrgent ? .systemRed : .systemIndigo
        priorityBadge.text = announcement.priority.uppercased()
        priorityBadge.textColor = isUrgent ? .white : .systemGreen
        priorityBadge.backgroundColor = isUrgent ? .systemRed : UIColor.systemGreen.withAlphaComponent(0.12)
        accessibilityLabel = "\(announcement.priority) announcement: \(announcement.title)"
    }
}

private extension UIFont {
    func bold() -> UIFont { UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold) ?? fontDescriptor, size: pointSize) }
}
