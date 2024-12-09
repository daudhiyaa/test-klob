//
//  JobCard.swift
//  TestKLOB
//
//  Created by Daud on 09/12/24.
//

import SwiftUI

struct JobCard: View {
    let positionName: String
    let corporateName: String
    let status: String
    let postedDate: String
    let salary: String?
    @State var isApplied: Bool
    let corporateLogo: String

    var body: some View {
        HStack {
            VStack{
                AsyncImage(url: URL(string: corporateLogo)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 40, height: 40)
                }
                
                Spacer()
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(positionName)
                    .font(.headline)
                Text(corporateName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                    Text(status)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if let salary = salary {
                        Text(salary)
                            .font(.caption)
                            .foregroundColor(.black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(4)
                    }
                }
                
                HStack {
                    Text(postedDate)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if isApplied {
                        Text("LAMARAN TERKIRIM")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray5))
                            .cornerRadius(12)
                    } else {
                        Button(action: {
                            isApplied = true
                            print("Apply button tapped for \(positionName)")
                        }) {
                            Text("LAMAR")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.customBlue)
                                .cornerRadius(12)
                        }
                    }
                }
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
