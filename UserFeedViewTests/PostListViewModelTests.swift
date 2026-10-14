//
//  PostListViewModelTests.swift
//  UserFeedViewTests
//
//  Created by Karthikeya K on 14/10/26.
//

import XCTest
import Foundation
@testable import UserFeedView

// MARK: - POST LIST VIEW MODEL TESTS
final class PostListViewModelTests: XCTestCase {
    
    @MainActor
    func testInitialState() {
        let viewModel = PostListViewModel(networkService: MockNetworkService())
        
        XCTAssertTrue(viewModel.posts.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor
    func testFetchPostsSuccess() async {
        // Arrange
        let stubbedPosts = [
            Post(userId: 1, id: 10, title: "Test Title 1", body: "Body content description 1"),
            Post(userId: 1, id: 11, title: "Test Title 2", body: "Body content description 2")
        ]
        var mockNetwork = MockNetworkService()
        mockNetwork.postsResult = .success(stubbedPosts)
        let viewModel = PostListViewModel(networkService: mockNetwork)
        
        // Act
        await viewModel.loadPosts()
        
        // Assert
        XCTAssertEqual(viewModel.posts.count, 2)
        XCTAssertEqual(viewModel.posts.first?.id, 10)
        XCTAssertEqual(viewModel.posts.last?.title, "Test Title 2")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor
    func testFetchPostsFailure() async {
        // Arrange
        var mockNetwork = MockNetworkService()
        let expectedError = URLError(.badServerResponse)
        mockNetwork.postsResult = .failure(expectedError)
        let viewModel = PostListViewModel(networkService: mockNetwork)
        
        // Act
        await viewModel.loadPosts()
        
        // Assert
        XCTAssertTrue(viewModel.posts.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription)
    }
    
    @MainActor
    func testLoadPostsSkipsWhenNotEmpty() async {
        // Arrange
        let initialPost = Post(userId: 1, id: 9, title: "Pre-existing", body: "Data description")
        var mockNetwork = MockNetworkService()
        mockNetwork.postsResult = .success([Post(userId: 1, id: 50, title: "New", body: "New text")])
        
        let viewModel = PostListViewModel(networkService: mockNetwork)
        viewModel.posts = [initialPost] // Seed data to trigger the guard skip
        
        // Act
        await viewModel.loadPosts()
        
        // Assert
        XCTAssertEqual(viewModel.posts.count, 1)
        XCTAssertEqual(viewModel.posts.first?.id, 9) // Confirms fetch was skipped
    }
}
