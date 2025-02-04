//
//  ListHeaderView.swift
//  NomikGlucose
//
//  Created by Nomik on 2025/2/3.
//

import UIKit
import DGCharts
import Combine

class ListHeaderView: UIView {
    
    // MARK: - Variables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    private var lineChart: LineChartView = {
        let lineChart = LineChartView()
        lineChart.backgroundColor = .systemBackground
        lineChart.rightAxis.enabled = false // 隱藏左邊Y軸
        lineChart.leftAxis.drawGridLinesEnabled = false
        lineChart.xAxis.enabled = false
        lineChart.xAxis.labelPosition = .bottom // X 軸底部
        lineChart.xAxis.granularity = 1 // X 軸標籤間距
        lineChart.highlightPerTapEnabled = false //關閉十字線
        lineChart.highlightPerDragEnabled = false //關閉十字線
        lineChart.doubleTapToZoomEnabled = false // 啟用雙擊縮放
        return lineChart
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lineChart)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineChart.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    public func bindView(to linePublisher: AnyPublisher<[GlucoseModel], Never>) {
        linePublisher.receive(on: DispatchQueue.main).sink { [weak self] lineDatas in
            self?.setupLineData(to: lineDatas)
        }
        .store(in: &cancellables)
    }
    
    private func setupLineData(to lineDatas: [GlucoseModel]) {
        
        let arraylist = lineDatas.prefix(15).reversed() //取得最新15次的血糖數據並且反轉
        
        let dataEntries: [ChartDataEntry] = arraylist.map{ ChartDataEntry(x: Double($0.tag), y: $0.glucoseDataValue) }
        
        // 設置數據集
        let dataSet = LineChartDataSet(entries: dataEntries, label: "最新十次血糖數據")
        dataSet.colors = [.systemIndigo] // 線條顏色
        dataSet.circleColors = [.systemOrange] // 圓點顏色
        dataSet.circleRadius = 4 // 圓點大小
        dataSet.lineWidth = 1 // 線條寬度
        dataSet.valueColors = [.white] // 資料標籤顏色
        
        // 設置 LineChartData 並賦值給圖表
        let lineChartData = LineChartData(dataSet: dataSet)
        self.lineChart.data = lineChartData
        self.lineChart.animate(xAxisDuration: 2.5, yAxisDuration: 2.5, easingOption: .linear)
    }
}
