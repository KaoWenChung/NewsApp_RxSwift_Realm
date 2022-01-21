//
//  NewsModel.swift
//  newstest_Owen
//
//  Created by owenkao on 2022/1/21.
//


struct NewsModel: Codable {
    let articles: [ArticleModel]?
    let status: String?
    let totalResults: Int?
    enum CodingKeys: String, CodingKey {
        case articles = "articles"
        case status = "status"
        case totalResults = "totalResults"
    }
}

struct ArticleModel: Codable {
    let author: String?
    let content: String?
    let descriptionField: String?
    let publishedAt: String?
    let source: SourceModel?
    let title: String?
    let url: String?
    let urlToImage: String?
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case content = "content"
        case descriptionField = "description"
        case publishedAt = "publishedAt"
        case source
        case title = "title"
        case url = "url"
        case urlToImage = "urlToImage"
    }
}

struct SourceModel: Codable {
    let id: String?
    let name: String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
