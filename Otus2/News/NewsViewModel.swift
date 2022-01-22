//
//  NewsViewModel.swift
//  Otus2
//
//  Created by Павел Лунев on 17.01.2022.
//

import Foundation
import Network
import ServiceLocator

final class NewsViewModel: ObservableObject {
    @Injected var networkService: NetworkService?
    @Published var articles: [Article] = []
    @Published var isPageLoading: Bool = false
    var page: Int = 0
    var totalResults: Int = Int.max

    init() {}

    func reloadPage(with theme: String) {
        guard totalResults > articles.count else {
            print("Nothing to load \(self.articles.count)/\(self.totalResults)")
            return
        }

        articles.removeAll()
        page = 0

        isPageLoading = true
        page += 1

        networkService?.everythingGet(q: theme, sortBy: .publishedAt, language: "ru", page: self.page, completion: { result in
            switch result {
            case .success(let articles):
                self.totalResults = articles?.totalResults ?? Int.max
                self.articles = articles?.articles ?? []
            case .failure(let error):
                print("\(error) error")
            }
            self.isPageLoading = false
        })
    }

    func loadNextPage(with theme: String) {
        guard isPageLoading == false && totalResults > articles.count else {
            print("Nothing to load \(self.articles.count)/\(self.totalResults)")
            return
        }
        isPageLoading = true
        page += 1

        networkService?.everythingGet(q: theme, sortBy: .publishedAt, language: "ru", page: self.page, completion: { result in
            switch result {
            case .success(let articles):
                self.totalResults = articles?.totalResults ?? Int.max
                self.articles.append(contentsOf: articles?.articles ?? [])
            case .failure(let error):
                print("\(error) error")
            }
            self.isPageLoading = false
        })
    }
}
