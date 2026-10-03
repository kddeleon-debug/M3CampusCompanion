import Foundation

struct CampusAnnouncement {
    let title: String
    let date: String
    let category: String
    let priority: String
    let postedBy: String
}

extension CampusAnnouncement {
    static let sampleAnnouncements: [CampusAnnouncement] = [
        CampusAnnouncement(title: "Enrollment Period Extended", date: "August 3, 2026", category: "Academic", priority: "Urgent", postedBy: "Registrar"),
        CampusAnnouncement(title: "Library Hours for Finals Week", date: "August 5, 2026", category: "Campus Services", priority: "Normal", postedBy: "Library Services"),
        CampusAnnouncement(title: "Student ID Validation", date: "August 7, 2026", category: "Registrar", priority: "Urgent", postedBy: "Registrar"),
        CampusAnnouncement(title: "Campus Wi-Fi Maintenance", date: "August 9, 2026", category: "Technology", priority: "Normal", postedBy: "IT Services"),
        CampusAnnouncement(title: "Intramurals Registration", date: "August 12, 2026", category: "Student Life", priority: "Normal", postedBy: "Student Affairs"),
        CampusAnnouncement(title: "Scholarship Application Deadline", date: "August 15, 2026", category: "Scholarships", priority: "Urgent", postedBy: "Financial Aid Office")
    ]
}
