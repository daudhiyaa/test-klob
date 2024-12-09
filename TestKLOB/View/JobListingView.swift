import SwiftUI
import Foundation

struct JobListingView: View {
    @StateObject private var viewModel = JobViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if viewModel.isLoading {
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
                            ForEach(viewModel.jobs) { job in
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
            .onAppear {
                viewModel.fetchJobs()
            }
            .navigationTitle("Lowongan Kerja")
        }
    }

    
}

#Preview {
    JobListingView()
}
