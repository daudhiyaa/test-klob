//
//  Job.swift
//  TestKLOB
//
//  Created by Daud on 09/12/24.
//

import Foundation

struct Job: Identifiable, Codable {
    let id = UUID().uuidString
    let positionName: String
    let corporateName: String
    let status: String
    let descriptions: String
    let corporateLogo: String
    let applied: Bool?
    let salaryFrom: Int
    let salaryTo: Int
    let postedDate: String?

    var salaryRange: String? {
        salaryFrom > 0 || salaryTo > 0 ? "IDR \(salaryFrom) - \(salaryTo)" : nil
    }

    var formattedPostedDate: String {
        // Convert and format date (if needed)
        if let postedDate = postedDate {
            return timeAgo(from: postedDate)
        } else {
            return ""
        }
    }
}
