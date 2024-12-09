import SwiftUI
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

struct JobListingView: View {
    @State private var jobs: [Job] = []
    @State private var isLoading: Bool = true

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if isLoading {
                    ProgressView("Loading jobs...")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    Text("Lowongan Pekerjaan")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(jobs) { job in
                                JobCard(
                                    positionName: job.positionName,
                                    corporateName: job.corporateName,
                                    status: job.status,
                                    postedDate: job.formattedPostedDate,
                                    salary: job.salaryRange,
                                    isApplied: job.applied ?? false,
                                    corporateLogo: job.corporateLogo
                                )
                            }
                        }
                        .padding()
                        
                        VStack {
                            Image("logo-footer-klob-white")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                            
                            Text("Copyright © 2024 PT DAYA5 REKRUTMEN")
                                .frame(maxWidth: .infinity)
                                .font(.caption)
                                .padding(.top, 4)
                        }
                        .padding(.vertical, 32)
                        .foregroundStyle(.white)
                        .background(Color.customBlue)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .onAppear(perform: fetchJobs)
            .navigationTitle("Lowongan Kerja")
        }
    }

    func fetchJobs() {
        guard let url = URL(string: "https://test-server-klob.onrender.com/fakeJob/apple/academy") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching jobs: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
//            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
//               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
//               let prettyString = String(data: prettyData, encoding: .utf8) {
//                print("Response JSON (pretty):\n\(prettyString)")
//            } else {
//                print("Failed to convert data to pretty JSON")
//            }

            do {
                let decodedJobs = try JSONDecoder().decode([Job].self, from: data)
                DispatchQueue.main.async {
                    self.jobs = decodedJobs
                    self.isLoading = false
                }
            } catch {
                print("Error decoding jobs: \(error.localizedDescription)")
            }
        }.resume()
    }
}

#Preview {
    JobListingView()
}
