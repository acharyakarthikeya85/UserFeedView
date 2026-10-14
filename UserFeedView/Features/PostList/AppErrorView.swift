//
//  AppErrorView.swift
//  UserFeedView
//
//  Created by Karthikeya K on 13/10/26.
//

import Foundation
import SwiftUI

struct AppErrorView: View {
    let title: String
    let systemImage: String
    let description: String
    let retryAction: () async -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(systemName: systemImage)
                .font(.system(size: 50))
                .foregroundColor(.secondary)
                .padding(.bottom, 8)
            
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.primary)
            
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .lineLimit(3)
            
            Button(action: {
                Task {
                    await retryAction()
                }
            }) {
                Text("Try Again")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.top, 8)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}
