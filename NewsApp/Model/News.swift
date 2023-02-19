//
//  Post.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 15.02.2023.
//

import Foundation

struct Article: Decodable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    var isFavorite: Bool?
}

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}


var favoritePostsArray = [Article]()
var articlesArray = [Article]()


