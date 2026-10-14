//
//  PostRowView.swift
//  UserFeedView
//
//  Created by Karthikeya K on 13/10/26.
//

import Foundation
import SwiftUI

// Subview extraction to keep the list body hyper-clean
struct PostRowView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(post.title.capitalized)
                .font(.headline)
                .lineLimit(1)
            Text(post.body)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .padding(.vertical, 4)
    }
}
