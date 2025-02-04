//
//  glucoseViewModel.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/30.
//

import Foundation
import HealthKit
import UIKit

class GlucoseViewModel: ObservableObject {
    @Published var allBloodGlucose: [GlucoseModel] = []
    @Published var avgbloodGlucose: [GlucoseModel] = []
    @Published var pieNumberRound: [Double] = []
    
    let healthStore = HKHealthStore()
    
    //取得全部血糖數據
    func fetchGlucoseData() {
        //請求授權
        if HKHealthStore.isHealthDataAvailable() {
            print("健康數據已開啟可使用")
        }
        
        let bloodGlucoseType = HKQuantityType.quantityType(forIdentifier: .bloodGlucose)!
        let readTypes: Set<HKObjectType> = [bloodGlucoseType]

        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            if success {
                print("授權成功，可以讀取血糖數據")
            } else if let error = error {
                print("授權失敗: \(error.localizedDescription)")
            }
        }
        
        let startDate = Calendar.current.date(byAdding: .day, value: -365, to: Date())!

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)

        let query = HKSampleQuery(sampleType: bloodGlucoseType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { [weak self] _, results, error in
            do {
                guard let datas = results as? [HKQuantitySample] else {
                    print("沒有血糖數據")
                    return
                }
                
                var allGlucoseJudgeColor: UIColor?
                
                for (i, data) in datas.enumerated() {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei")!
                    let formattedDate = dateFormatter.string(from: data.startDate)
                    
                    let newBloodGlucose = data.quantity.doubleValue(for: HKUnit(from: "mg/dL"))
                    
                    if newBloodGlucose >= 160 {
                        allGlucoseJudgeColor = .orange
                    }else if newBloodGlucose > 130 && newBloodGlucose < 160{
                        allGlucoseJudgeColor = .systemYellow
                    }else if newBloodGlucose >= 80 && newBloodGlucose <= 130 {
                        allGlucoseJudgeColor = .systemGreen
                    }else if newBloodGlucose < 80 && newBloodGlucose > 0{
                        allGlucoseJudgeColor = .systemRed
                    }else {
                        allGlucoseJudgeColor = .white
                    }
                    self?.allBloodGlucose.append(GlucoseModel(glucoseDataValue: newBloodGlucose, glucoseDate: formattedDate, glucoseColor: allGlucoseJudgeColor ?? .white, tag: i))
                }
                self?.allBloodGlucose.sort{ $0.tag > $1.tag }
            } catch {
                print("讀取血糖數據失敗: \(error.localizedDescription)")
            }
        }
        healthStore.execute(query)
    }
    
    //取得平均血糖數據
    func fetchAvgbloodGlucoseData() {
        //請求授權
        if HKHealthStore.isHealthDataAvailable() {
            print("健康數據已開啟可使用")
        }
        
        let bloodGlucoseType = HKQuantityType.quantityType(forIdentifier: .bloodGlucose)!
        let readTypes: Set<HKObjectType> = [bloodGlucoseType]

        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            if success {
                print("授權成功，可以讀取血糖數據")
            } else if let error = error {
                print("授權失敗: \(error.localizedDescription)")
            }
        }
        
        let days = [-7, -14, -30, -90]
        
        for (i, day) in days.enumerated() {
            let startDate = Calendar.current.date(byAdding: .day, value: day, to: Date())!
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)

            let query = HKSampleQuery(sampleType: bloodGlucoseType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { [weak self] _, results, error in
                do {
                    guard let datas = results as? [HKQuantitySample] else {
                        print("沒有血糖數據")
                        return
                    }
                    
                    var avg: Double = 0.0
                    var glucoseJudgeColor: UIColor?
                    
                    for data in datas {
                        let BloodGlucoses = data.quantity.doubleValue(for: HKUnit(from: "mg/dL"))
                        avg += BloodGlucoses
                    }
                    let avgValue = avg / Double(datas.count)
                    
                    if avgValue >= 160 {
                        glucoseJudgeColor = .orange
                    }else if avgValue > 130 && avgValue < 160{
                        glucoseJudgeColor = .systemYellow
                    }else if avgValue >= 80 && avgValue <= 130 {
                        glucoseJudgeColor = .systemGreen
                    }else if avgValue < 80 && avgValue > 0 {
                        glucoseJudgeColor = .systemRed
                    }else {
                        glucoseJudgeColor = .white
                    }
                    
                    let avgRound = String(format: "%.1f", avgValue)
                    
                    self?.avgbloodGlucose.append(GlucoseModel(glucoseDataValue: Double(avgRound) ?? 0.0, glucoseDate: "\(abs(day))", glucoseColor: glucoseJudgeColor ?? .white, tag: i))
                } catch {
                    print("讀取血糖數據失敗: \(error.localizedDescription)")
                }
            }
            healthStore.execute(query)
        }
    }
    
    //取得圓餅圖血糖數據
    func fetchPieBloodGlucoseData(_ day: Int) {
        //請求授權
        if HKHealthStore.isHealthDataAvailable() {
            print("健康數據已開啟可使用")
        }
        
        let bloodGlucoseType = HKQuantityType.quantityType(forIdentifier: .bloodGlucose)!
        let readTypes: Set<HKObjectType> = [bloodGlucoseType]

        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            if success {
                print("授權成功，可以讀取血糖數據")
            } else if let error = error {
                print("授權失敗: \(error.localizedDescription)")
            }
        }
        
        let startDate = Calendar.current.date(byAdding: .day, value: -day, to: Date())!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)

        let query = HKSampleQuery(sampleType: bloodGlucoseType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { [weak self] _, results, error in
            do {
                guard let datas = results as? [HKQuantitySample] else {
                    print("沒有血糖數據")
                    return
                }
                
                var pieBloodGlucose: [Double] = []
                var pieNumber: [Double] = []
                
                for data in datas {
                    pieBloodGlucose.append(data.quantity.doubleValue(for: HKUnit(from: "mg/dL")))
                }
                
                pieNumber.append(Double(pieBloodGlucose.filter{ $0 > 160 }.count))
                pieNumber.append(Double(pieBloodGlucose.filter{ $0 >= 130 && $0 <= 160 }.count))
                pieNumber.append(Double(pieBloodGlucose.filter{ $0 >= 80 && $0 <= 130 }.count))
                pieNumber.append(Double(pieBloodGlucose.filter{ $0 < 80 }.count))
               
                let totel = pieNumber.reduce(0.0) { $0 + $1 }
                
                DispatchQueue.main.async {
                    self?.pieNumberRound = pieNumber.map{ (($0 / totel) * 100).rounded() }
                }
            } catch {
                print("讀取血糖數據失敗: \(error.localizedDescription)")
            }
        }
        healthStore.execute(query)
    }
}
