//
//  glucoseViewModel.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/30.
//

import Foundation
import HealthKit

class GlucoseViewModel: ObservableObject {
    @Published var newBloodGlucoseData: GlucoseModel?
    @Published var bloodGlucoseAvg: [GlucoseModel] = []
    
    let healthStore = HKHealthStore()
    
    func newGlucoseData() {
        if HKHealthStore.isHealthDataAvailable() {
            print("健康數據已開啟可使用")
        }
        
        let bloodGlucoseType = HKQuantityType.quantityType(forIdentifier: .bloodGlucose)!
        
        //請求授權
        let readTypes: Set<HKObjectType> = [bloodGlucoseType]

        healthStore.requestAuthorization(toShare: nil, read: readTypes) { (success, error) in
            if success {
                print("授權成功，可以讀取血糖數據")
            } else if let error = error {
                print("授權失敗: \(error.localizedDescription)")
            }
        }
        
        //取得血糖數據
        let startDate = Calendar.current.date(byAdding: .day, value: -365, to: Date())!
        let endDate = Date()

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKSampleQuery(sampleType: bloodGlucoseType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { [weak self] (_, results, error) in
            do {
                guard let datas = results as? [HKQuantitySample] else {
                    print("沒有血糖數據")
                    return
                }
                
                for data in datas {
                    let newBloodGlucose = data.quantity.doubleValue(for: HKUnit(from: "mg/dL"))
                    let date = data.startDate
                    let twTimeZone = TimeZone(identifier: "Asia/Taipei")!
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.timeZone = twTimeZone
                    let formattedDate = dateFormatter.string(from: date)
                    self?.newBloodGlucoseData = GlucoseModel(glucoseDataValue: newBloodGlucose, glucoseDate: formattedDate)
                }
            } catch {
                print("讀取血糖數據失敗: \(error.localizedDescription)")
            }
        }
        healthStore.execute(query)
    }
    
    func bloodGlucoseData() {
        if HKHealthStore.isHealthDataAvailable() {
            print("健康數據已開啟可使用")
        }
        
        let bloodGlucoseType = HKQuantityType.quantityType(forIdentifier: .bloodGlucose)!
        let readTypes: Set<HKObjectType> = [bloodGlucoseType] //請求授權

        healthStore.requestAuthorization(toShare: nil, read: readTypes) { (success, error) in
            if success {
                print("授權成功，可以讀取血糖數據")
            } else if let error = error {
                print("授權失敗: \(error.localizedDescription)")
            }
        }
        
        let numbers = [-7, -14, -30, -90]
        
        for i in numbers {
            let startDate = Calendar.current.date(byAdding: .day, value: i, to: Date())!
            let endDate = Date()
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

            let query = HKSampleQuery(sampleType: bloodGlucoseType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { [weak self] (_, results, error) in
                do {
                    guard let datas = results as? [HKQuantitySample] else {
                        print("沒有血糖數據")
                        return
                    }
                    
                    var avg: Double = 0.0
                    
                    for data in datas {
                        let sevenBloodGlucose = data.quantity.doubleValue(for: HKUnit(from: "mg/dL"))
                        avg += sevenBloodGlucose
                    }
                    let avgValue = avg / Double(abs(i))
                    let avgRound = String(format: "%.1f", avgValue)
                    self?.bloodGlucoseAvg.append(GlucoseModel(glucoseDataValue: Double(avgRound) ?? 0.0, glucoseDate: "\(abs(i))"))
                } catch {
                    print("讀取血糖數據失敗: \(error.localizedDescription)")
                }
            }
            healthStore.execute(query)
        }
    }
}
