//
//  GeminiModel.swift
//  NomikGlucose
//
//  Created by Nomik on 2025/1/20.
//

import Foundation

struct GeminiModel: Codable {
    let candidates: [Candidates]
}

struct Candidates: Codable {
    let content: Content
}

struct Content: Codable {
    let parts: [Parts]
}

struct Parts: Codable {
    let text: String
}
