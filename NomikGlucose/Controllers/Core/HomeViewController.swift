//
//  HomeViewController.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/26.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private let glucoseViewModel = GlucoseViewModel()
    private let newsViewModel = NewsViewModel()
    
    // MARK: - Variables
    lazy var headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250))
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    private let homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none //禁止使用分隔線
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AverageTableViewCell.self, forCellReuseIdentifier: AverageTableViewCell.identifier)
        tableView.register(ConversionTableViewCell.self, forCellReuseIdentifier: ConversionTableViewCell.identifier)
        tableView.register(GlucoseNewTableViewCell.self, forCellReuseIdentifier: GlucoseNewTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.addSubview(homeTableView)
        view.backgroundColor = .black
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        headerView.layer.cornerRadius = 50
        headerView.clipsToBounds = true
        homeTableView.tableHeaderView = headerView
        homeTableView.contentInsetAdjustmentBehavior = .never
        
        bindView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTableView.frame = view.bounds
    }
    
    // MARK: - Functions
    private func bindView() {
        glucoseViewModel.newGlucoseData()
        glucoseViewModel.bloodGlucoseData()
        newsViewModel.fetchNewsData()
        
        glucoseViewModel.$newBloodGlucoseData.receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.headerView.configureData(to: data?.glucoseDataValue ?? 0.0)
            }
            .store(in: &cancellables)
        
        glucoseViewModel.$bloodGlucoseAvg.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.homeTableView.reloadData()
            }
            .store(in: &cancellables)
        
        newsViewModel.$newsDatas.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.homeTableView.reloadData()
            }
            .store(in: &cancellables)
    }
}
// MARK: - Extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 50
        default:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 140
        case 1:
            return 100
        default:
            return 400
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let AverageHeaderView = UIView()
            let label = UILabel()
            label.text = "平均血糖 Average Glucose"
            label.font = .systemFont(ofSize: 24, weight: .semibold)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            AverageHeaderView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: AverageHeaderView.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: AverageHeaderView.trailingAnchor),
                label.topAnchor.constraint(equalTo: AverageHeaderView.topAnchor),
                label.bottomAnchor.constraint(equalTo: AverageHeaderView.bottomAnchor),
            ])

            return AverageHeaderView
        case 1:
            let AverageHeaderView = UIView()
            let label = UILabel()
            label.text = "血糖換算 Glucose Conversion"
            label.font = .systemFont(ofSize: 24, weight: .semibold)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            AverageHeaderView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: AverageHeaderView.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: AverageHeaderView.trailingAnchor),
                label.topAnchor.constraint(equalTo: AverageHeaderView.topAnchor),
                label.bottomAnchor.constraint(equalTo: AverageHeaderView.bottomAnchor),
            ])

            return AverageHeaderView
        default:
            let glucoseNewHeaderView = UIView()
            let label = UILabel()
            label.text = "血糖新聞 Glucose New"
            label.font = .systemFont(ofSize: 24, weight: .semibold)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            glucoseNewHeaderView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: glucoseNewHeaderView.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: glucoseNewHeaderView.trailingAnchor),
                label.topAnchor.constraint(equalTo: glucoseNewHeaderView.topAnchor),
                label.bottomAnchor.constraint(equalTo: glucoseNewHeaderView.bottomAnchor),
            ])

            return glucoseNewHeaderView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AverageTableViewCell.identifier, for: indexPath) as? AverageTableViewCell else { return UITableViewCell() }
            cell.configureData(with: glucoseViewModel.bloodGlucoseAvg)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ConversionTableViewCell.identifier, for: indexPath) as? ConversionTableViewCell else { return UITableViewCell() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GlucoseNewTableViewCell.identifier, for: indexPath) as? GlucoseNewTableViewCell else { return UITableViewCell() }
            if let newsDatas = newsViewModel.newsDatas {
                cell.configureData(with: newsDatas)
            }
            cell.newsItemSelected.sink { [weak self] url in
                let webVC = WebViewController()
                webVC.webSetting(to: url)
                self?.present(webVC, animated: true)
            }
            .store(in: &cancellables)
            return cell
        }
    }
}
