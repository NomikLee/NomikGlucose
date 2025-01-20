//
//  GeminiViewModel.swift
//  NomikGlucose
//
//  Created by Nomik on 2025/1/20.
//

import Foundation
import Combine

class GeminiViewModel: ObservableObject {
    @Published var aiFeedbackInfos: GeminiModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchAiFeedback(to glucoseValue: Double) {
        APIServiceManager.shared.getGeminiData(to: glucoseValue).sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] datas in
            self?.aiFeedbackInfos = datas
        }
        .store(in: &cancellables)
    }
}
