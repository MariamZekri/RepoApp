//
//  RepoModel.swift
//  RepositoriesApp
//
//  Created by Mariam Abdelhamid on 8/31/24.
//

import Foundation

// MARK: - RepoModel
struct RepoModel: Codable {
    let totalCount: Int?
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

// MARK: - Item
struct Item: Codable {
    let id: Int?
    let name: String?
    let description: String?
}
