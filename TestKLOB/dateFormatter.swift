//
//  dateFormatter.swift
//  TestKLOB
//
//  Created by Daud on 09/12/24.
//

import Foundation

func timeAgo(from dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistent parsing
    guard let date = dateFormatter.date(from: dateString) else {
        return "Invalid date"
    }

    let relativeFormatter = RelativeDateTimeFormatter()
    relativeFormatter.unitsStyle = .full // Use full units like "a month ago"
    
    let timeAgo = relativeFormatter.localizedString(for: date, relativeTo: Date())
    return timeAgo
}

