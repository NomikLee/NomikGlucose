//
//  FirebaseServiceManager.swift
//  NomikGlucose
//
//  Created by Nomik on 2025/2/3.
//

import Foundation
import Firebase
import Combine

class FirebaseServiceManager {
    
    static let shard = FirebaseServiceManager()
    
    private let db = Firestore.firestore()
    
    //取得Firebase食物Manager
    func fetchFirebaseData() -> AnyPublisher<[String: [String: String]], Error> {
        return Future { promise in
            self.db.collection("users").getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                }else {
                    //reduce(into:_:)
                    let dataDict = snapshot?.documents.reduce(into: [String: [String: String]]()) { result, doc in
                        result[doc.documentID] = doc.data() as? [String: String] ?? [:]
                    }
                    
                    if let dataDict = dataDict {
                        promise(.success(dataDict))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    //上傳Firebase食物資料Manager
    func saveFirebaseData(to date: String, measureTimeSelect: String, foodText: String) -> AnyPublisher<Void, Error> {
        return Future { promise in
            self.db.collection("users").document(date).setData([measureTimeSelect: foodText], merge: false) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
