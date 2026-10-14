//
//  PostDetailView.swift
//  UserFeedView
//
//  Created by Karthikeya K on 13/10/26.
//

import Foundation
import SwiftUI

// MARK: - VIEW
struct PostDetailView: View {
    @StateObject private var viewModel: PostDetailViewModel
    
    // Custom dependency injection initializer
    init(postId: Int) {
        _viewModel = StateObject(wrappedValue: PostDetailViewModel(postId: postId))
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Fetching details...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if let post = viewModel.post {
                PostDetailContentView(post: post)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadDetail()
        }
    }
}
