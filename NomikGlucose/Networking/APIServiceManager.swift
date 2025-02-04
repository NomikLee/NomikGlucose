//
//  APIServiceManager.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/31.
//

import Foundation
import Combine

class APIServiceManager {
    
    static let shared = APIServiceManager()
    
    func getNewsData() -> AnyPublisher<NewsModel, Error> {
        var urlComponents = URLComponents(string: Constants.newsBaseUrl)
        
        let queryItems = [
            URLQueryItem(name: "q", value: "血糖"),
            URLQueryItem(name: "apiKey", value: Constants.newsApiKey),
        ]
        
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map{ $0.data }
            .decode(type: NewsModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getGeminiData(to glucoseValueDate: String, glucoseValue: Double) -> AnyPublisher<GeminiModel, Error> {
        var urlComponent = URLComponents(string: Constants.geminiBaseUrl)
        
        let queryItems = [URLQueryItem(name: "key", value: Constants.geminiApiKey)]
        
        urlComponent?.queryItems = queryItems
        guard let url = urlComponent?.url else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let json: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": "\(glucoseValueDate)平均為\(glucoseValue) 給我分析並建議"]
                    ]
                ]
            ]
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map{ $0.data }
            .decode(type: GeminiModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
