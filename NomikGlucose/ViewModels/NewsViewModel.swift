//
//  NewsViewModel.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/31.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var newsDatas: NewsModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchNewsData() {
        APIServiceManager.shared.getNewsData().sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] newsData in
            self?.newsDatas = newsData
        }
        .store(in: &cancellables)
    }
}


