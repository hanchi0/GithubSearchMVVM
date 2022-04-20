//
//  Repository.swift
//  GithubSearchMVVM
//
//  Created by 한지민 on 2022/03/17.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let nodeId: String
    let fullName: String
    let description: String?
    let url: String
    let htmlUrl: String
    let createdAt: String
    let updatedAt: String
}
