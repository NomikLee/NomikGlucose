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
        
        let twTimeZone = TimeZone(identifier: "Asia/Taipei")!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = twTimeZone
        let formattedDate = dateFormatter.string(from: Date())
        
        var urlComponents = URLComponents(string: Constants.baseUrl)
        
        let queryItems = [
            URLQueryItem(name: "q", value: "糖尿病"),
            URLQueryItem(name: "sortBy", value: "popularity"),
            URLQueryItem(name: "apiKey", value: Constants.apiKey),
        ]
        
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: NewsModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
