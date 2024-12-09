//
//  JobListingViewModel.swift
//  TestKLOB
//
//  Created by Daud on 09/12/24.
//

import Foundation

class JobViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil

    func fetchJobs() {
        guard let url = URL(string: "https://test-server-klob.onrender.com/fakeJob/apple/academy") else {
            self.errorMessage = "Invalid URL"
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error fetching jobs: \(error.localizedDescription)"
                    self.isLoading = false
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                    self.isLoading = false
                }
                return
            }

            do {
                let decodedJobs = try JSONDecoder().decode([Job].self, from: data)
                DispatchQueue.main.async {
                    self.jobs = decodedJobs
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Error decoding jobs: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }.resume()
    }
}

