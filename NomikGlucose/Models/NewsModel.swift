//
//  NewsModel.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/31.
//

import Foundation

struct NewsModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsDatas]
}

struct NewsDatas: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}
