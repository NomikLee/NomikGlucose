//
//  FirebaseViewModel.swift
//  NomikGlucose
//
//  Created by Nomik on 2025/1/31.
//

import Foundation
import Combine

class FirebaseViewModel: ObservableObject {
    @Published var getData: [String : [String : String]] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    //取得Firebase食物資料
    func getFirebaseData() {
        FirebaseServiceManager.shard.fetchFirebaseData()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] fetchData in
                self?.getData = fetchData
            }
            .store(in: &cancellables)
    }
    
    //上傳Firebase食物資料
    func setFirebaseData(to data: String, measureTimeSelect: String, foodText: String) {
        FirebaseServiceManager.shard.saveFirebaseData(to: data, measureTimeSelect: measureTimeSelect, foodText: foodText).receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { _ in
                print("資料上傳成功")
            }
            .store(in: &cancellables)
    }
}
