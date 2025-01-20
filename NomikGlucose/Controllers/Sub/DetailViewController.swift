//
//  DetailViewController.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2025/1/7.
//

import UIKit
import Combine

class DetailViewController: UIViewController {

    // MARK: - Variables
    private let glucoseViewModel = GlucoseViewModel()
    private let geminiViewModel = GeminiViewModel()
    
    private var stateString: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    private lazy var detailHeaderView: DetailHeaderView = {
        let headerView = DetailHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 300), title: self.title ?? "")
        return headerView
    }()
    
    private let detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailTableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        detailTableView.tableHeaderView = detailHeaderView
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        configureData(title ?? "")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailTableView.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Functions
    public func bindView(_ glucoseValue: Double) {
        if glucoseValue.isNaN == true {
            stateString = "無量測數據可以給AI分析"
        } else {
            geminiViewModel.fetchAiFeedback(to: glucoseValue)
            stateString = "AI分析中請稍後..."
            geminiViewModel.$aiFeedbackInfos.sink { [weak self] _ in
                self?.detailTableView.reloadData()
            }
            .store(in: &cancellables)
        }
    }
    
    private func configureData(_ title: String) {
        switch title {
        case "過去7天血糖":
            glucoseViewModel.fetchPieBloodGlucoseData(7)
            detailHeaderView.bindView(to: glucoseViewModel.$pieNumberRound.eraseToAnyPublisher())
        case "過去14天血糖":
            glucoseViewModel.fetchPieBloodGlucoseData(14)
            detailHeaderView.bindView(to: glucoseViewModel.$pieNumberRound.eraseToAnyPublisher())
        case "過去30天血糖":
            glucoseViewModel.fetchPieBloodGlucoseData(30)
            detailHeaderView.bindView(to: glucoseViewModel.$pieNumberRound.eraseToAnyPublisher())
        case "過去90天血糖":
            glucoseViewModel.fetchPieBloodGlucoseData(90)
            detailHeaderView.bindView(to: glucoseViewModel.$pieNumberRound.eraseToAnyPublisher())
        default:
            break
        }
    }
    
    // MARK: - UI Setup

}
// MARK: - Extension
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
        cell.configureData(with: geminiViewModel.aiFeedbackInfos?.candidates[indexPath.row].content.parts[indexPath.row].text ?? "\(stateString)")
        return cell
    }
}
