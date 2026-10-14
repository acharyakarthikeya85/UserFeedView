//
//  PostDetailContentView.swift
//  UserFeedView
//
//  Created by Karthikeya K on 13/10/26.
//

import Foundation
import SwiftUI

// Subview abstraction for data layout configuration
struct PostDetailContentView: View {
    let post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // 1. Editorial Header Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("ARTICLE")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.blue)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(6)
                    
                    Text(post.title.capitalized)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineSpacing(4)
                }
                .padding(.top, 8)
                
                // 2. Metadata Capsule Cards
                HStack(spacing: 12) {
                    HStack(spacing: 6) {
                        Image(systemName: "person.circle.fill")
                        Text("User ID: \(post.userId)")
                    }
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "number.circle.fill")
                        Text("Item ID: \(post.id)")
                    }
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                    
                    Spacer()
                }
                
                Divider()
                    .padding(.vertical, 4)
                
                // 3. Body Content Container Card
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "doc.text.fill")
                            .foregroundColor(.secondary)
                        Text("Content Body")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(post.body)
                        .font(.body)
                        .foregroundColor(.primary.opacity(0.85))
                        .lineSpacing(8) // Clean typographic breathability
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemBackground).opacity(0.6))
                .cornerRadius(16)
            }
            .padding(20)
        }
        .background(Color(.systemBackground))
    }
}
