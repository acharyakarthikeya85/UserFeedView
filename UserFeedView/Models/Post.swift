//
//  Post.swift
//  UserFeedView
//
//  Created by Karthikeya K on 13/10/26.
//

import Foundation

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
