//
//  PostListView.swift
//  UserFeedView
//
//  Created by Karthikeya K on 13/10/26.
//

import Foundation
import SwiftUI

// MARK: - VIEW
struct PostListView: View {
    @StateObject private var viewModel = PostListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading items...")
                } else if let errorMessage = viewModel.errorMessage {
                    AppErrorView(
                        title: "Loading Failed",
                        systemImage: "exclamationmark.triangle",
                        description: errorMessage,
                        retryAction: { await viewModel.loadPosts() }
                    )
                } else {
                    List(viewModel.posts) { post in
                        NavigationLink(destination: PostDetailView(postId: post.id)) {
                            PostRowView(post: post)
                        }
                    }
                }
            }
            .navigationTitle("UserFeedView")
            .task {
                await viewModel.loadPosts()
            }
        }
    }
}
