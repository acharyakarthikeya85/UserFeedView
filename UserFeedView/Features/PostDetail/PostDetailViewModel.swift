//
//  PostDetailViewModel.swift
//  UserFeedView
//
//  Created by Karthikeya K on 13/10/26.
//

import Foundation
import SwiftUI

// MARK: - VIEW MODEL
@MainActor
class PostDetailViewModel: ObservableObject {
    @Published var post: Post? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let postId: Int
    private let networkService: NetworkServiceProtocol
    
    init(postId: Int, networkService: NetworkServiceProtocol = NetworkManager.shared) {
        self.postId = postId
        self.networkService = networkService
    }
    
    func loadDetail() async {
        isLoading = true
        errorMessage = nil
        
        do {
            post = try await networkService.fetchPostDetail(id: postId)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
