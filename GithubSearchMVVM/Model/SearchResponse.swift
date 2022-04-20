//
//  SearchResponse.swift
//  GithubSearchMVC
//
//  Created by 한지민 on 2022/03/17.
//

import Foundation

struct SearchResponse: Codable {
    var totalCount: Int = 0
    var incompleteResults: Bool = false
    var items: [Repository] = []
}
