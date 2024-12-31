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
        APIServiceManager.shared.getNewsData()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] result in
                self?.newsDatas = result
            }
            .store(in: &cancellables)
    }
}
