//
//  PostDetailViewModelTests.swift
//  UserFeedViewTests
//
//  Created by Karthikeya K on 14/10/26.
//

import XCTest
import Foundation
@testable import UserFeedView


struct MockNetworkService: NetworkServiceProtocol {
    var postsResult: Result<[Post], Error>? = nil
    var detailResult: Result<Post, Error>? = nil
    
    func fetchPosts() async throws -> [Post] {
        switch postsResult {
        case .success(let posts): return posts
        case .failure(let error): throw error
        case .none: throw URLError(.unknown)
        }
    }
    
    func fetchPostDetail(id: Int) async throws -> Post {
        switch detailResult {
        case .success(let post): return post
        case .failure(let error): throw error
        case .none: throw URLError(.unknown)
        }
    }
}


// MARK: - POST DETAIL VIEW MODEL TESTS
final class PostDetailViewModelTests: XCTestCase {
    
    @MainActor
    func testInitialState() {
        let viewModel = PostDetailViewModel(postId: 42, networkService: MockNetworkService())
        
        XCTAssertNil(viewModel.post)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor
    func testFetchDetailSuccess() async {
        // Arrange
        let stubbedPost = Post(userId: 2, id: 42, title: "Deep Dive Item", body: "Granular information contents")
        var mockNetwork = MockNetworkService()
        mockNetwork.detailResult = .success(stubbedPost)
        let viewModel = PostDetailViewModel(postId: 42, networkService: mockNetwork)
        
        // Act
        await viewModel.loadDetail()
        
        // Assert
        XCTAssertNotNil(viewModel.post)
        XCTAssertEqual(viewModel.post?.id, 42)
        XCTAssertEqual(viewModel.post?.userId, 2)
        XCTAssertEqual(viewModel.post?.title, "Deep Dive Item")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor
    func testFetchDetailFailure() async {
        // Arrange
        var mockNetwork = MockNetworkService()
        let expectedError = URLError(.notConnectedToInternet)
        mockNetwork.detailResult = .failure(expectedError)
        let viewModel = PostDetailViewModel(postId: 42, networkService: mockNetwork)
        
        // Act
        await viewModel.loadDetail()
        
        // Assert
        XCTAssertNil(viewModel.post)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription)
    }
}
