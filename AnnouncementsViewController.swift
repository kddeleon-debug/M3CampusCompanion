import UIKit

final class AnnouncementsViewController: UITableViewController {
    private let announcements = CampusAnnouncement.sampleAnnouncements
    var onSelectAnnouncement: ((CampusAnnouncement) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Campus Announcements"
        tableView.register(AnnouncementCell.self, forCellReuseIdentifier: AnnouncementCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 16)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        announcements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnnouncementCell.reuseIdentifier, for: indexPath) as? AnnouncementCell else {
            return UITableViewCell()
        }
        cell.configure(with: announcements[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onSelectAnnouncement?(announcements[indexPath.row])
    }
}
