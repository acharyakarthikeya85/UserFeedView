//
//  NetworkManager.swift
//  UserFeedView
//
//  Created by Karthikeya K on 13/10/26.
//

import Foundation

protocol NetworkServiceProtocol: Sendable {
    func fetchPosts() async throws -> [Post]
    func fetchPostDetail(id: Int) async throws -> Post
}

// Singleton network manager class
struct NetworkManager: NetworkServiceProtocol {
    static let shared = NetworkManager()
    private init() {}
    
    // List of posts in first page
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([Post].self, from: data)
    }
    
    // Individual post for detail screen
    func fetchPostDetail(id: Int) async throws -> Post {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)") else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(Post.self, from: data)
    }
}
