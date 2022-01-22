//
//  NewsModel.swift
//  newstest_Owen
//
//  Created by owenkao on 2022/1/21.
//

import SwiftyJSON

struct NewsModel: Mapable {
    let articles: [ArticleModel]?
    let status: String?
    let totalResults: Int?
    init?(jsonData: JSON) {
        self.articles = jsonData["articles"].arrayObject as? [ArticleModel]
        self.status = jsonData["status"].string
        self.totalResults = jsonData["totalResults"].int
    }
}

struct ArticleModel: Mapable {
    let author: String?
    let content: String?
    let descriptionField: String?
    let publishedAt: String?
    let source: SourceModel?
    let title: String?
    let url: String?
    let urlToImage: String?
    init?(jsonData: JSON) {
        self.author = jsonData["author"].string
        self.content = jsonData["content"].string
        self.descriptionField = jsonData["descriptionField"].string
        self.publishedAt = jsonData["publishedAt"].string
        self.source = jsonData["source"].object as? SourceModel
        self.title = jsonData["title"].string
        self.url = jsonData["url"].string
        self.urlToImage = jsonData["urlToImage"].string
    }
}

struct SourceModel: Mapable {
    let id: String?
    let name: String?
    init?(jsonData: JSON) {
        self.id = jsonData["id"].string
        self.name = jsonData["name"].string
    }
}
