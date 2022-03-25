//
//  SearchViewModel.swift
//  GithubSearchMVVM
//
//  Created by 한지민 on 2022/03/17.
//

import Foundation
import Combine
import SwiftUI

protocol SearchViewModelInput {
    func fetchRepositories(text: String?)
}

protocol SearchViewModelOutput {
    var repositoriesPublisher: Published<[Repository]>.Publisher { get }
}

protocol SearchViewModelProtocol: SearchViewModelInput, SearchViewModelOutput {
    var repositories: [Repository] { get }
}

class SearchViewModel: SearchViewModelProtocol {
    @Published var repositories: [Repository] = []
    var repositoriesPublisher: Published<[Repository]>.Publisher { $repositories }
    
    var cancelBag = Set<AnyCancellable>()
    
    func fetchRepositories(text: String?) {
        var urlComponents = URLComponents(string: "https://api.github.com/search/repositories")
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: text)
        ]
        
        URLSession.shared.dataTaskPublisher(for: (urlComponents?.url)!)
            .map { $0.data }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .map { $0.items }
            .replaceError(with: [])
            .assign(to: \.repositories, on: self)
            .store(in: &cancelBag)
    }
}
