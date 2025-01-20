//
//  DetailHeaderView.swift
//  NomikGlucose
//
//  Created by Nomik on 2025/1/15.
//

import UIKit
import DGCharts
import Combine

class DetailHeaderView: UIView {
    
    // MARK: - Variables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    private let pieChartView: PieChartView = {
        let pie = PieChartView()
        pie.holeColor = .black // 中間的圓孔背景色
        pie.legend.enabled = true // 是否顯示圖例
        return pie
    }()
    
    // MARK: - Lifecycle
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(pieChartView)
        pieChartView.centerText = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pieChartView.frame = bounds
    }
    
    // MARK: - Functions
    public func bindView(to piePublisher: AnyPublisher<[Double], Never>) {
        piePublisher.sink { [weak self] pieDatas in
            self?.setupPieData(to: pieDatas)
        }
        .store(in: &cancellables)
    }
    
    private func setupPieData(to pieValue: [Double]) {
        
        guard pieValue.count >= 4 else { return }
        
        let datas = [
            PieChartDataEntry(value: pieValue[0], label: "160 以上"),
            PieChartDataEntry(value: pieValue[1], label: "130 ~ 160"),
            PieChartDataEntry(value: pieValue[2], label: "80 ~ 130"),
            PieChartDataEntry(value: pieValue[3], label: "80 以下")
        ]
        
        // 數據轉為 DataSet
        let dataSet = PieChartDataSet(entries: datas, label: "")
        dataSet.colors = [
            UIColor.orange,
            UIColor.systemYellow,
            UIColor.systemGreen,
            UIColor.systemRed
        ]
        
        // 設置 PieData
        let data = PieChartData(dataSet: dataSet)
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 12, weight: .bold))
        
        pieChartView.data = data
    }
}
