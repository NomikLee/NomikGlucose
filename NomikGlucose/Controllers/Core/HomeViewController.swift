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
    private lazy var headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250))
    private let refreshControl = UIRefreshControl()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    private let homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none //禁止使用分隔線
        tableView.showsVerticalScrollIndicator = false //禁止使用捲動bar
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(cancelKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        bindView()
        refreshData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTableView.frame = view.bounds
    }
    
    // MARK: - Functions
    private func bindView() {
        glucoseViewModel.fetchGlucoseData()
        glucoseViewModel.fetchAvgbloodGlucoseData()
        newsViewModel.fetchNewsData()
        
        glucoseViewModel.$allBloodGlucose.sink { [weak self] allGlucoseDatas in
            self?.headerView.configureData(to: allGlucoseDatas.last?.glucoseDataValue ?? 0.0, color: allGlucoseDatas.last?.glucoseColor ?? .white)
                                            }
                                            .store(in: &cancellables)
        
        glucoseViewModel.$avgbloodGlucose.sink { [weak self] _ in
                                                self?.homeTableView.reloadData()
                                            }
                                            .store(in: &cancellables)
        
        newsViewModel.$newsDatas.sink { [weak self] _ in
            self?.homeTableView.reloadData()
        }
        .store(in: &cancellables)
    }
    
    private func refreshData() {
        refreshControl.tintColor = .systemMint
        refreshControl.attributedTitle = NSAttributedString(string: "血糖資料加載中...", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold), .foregroundColor: UIColor.white])
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        homeTableView.refreshControl = refreshControl
    }
    
    // MARK: - Selectors
    @objc private func refreshView() {
        cancellables.removeAll()
        glucoseViewModel.avgbloodGlucose.removeAll()
        bindView()
        
        //下拉時homeTableView下降50
        UIView.animate(withDuration: 0.3) {
            self.homeTableView.contentInset.top += 50
        }
        
        //2秒後homeTableView回到初始位置
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.3) {
                self.homeTableView.contentInset.top -= 50
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    //下彈視窗
    @objc func tapAverageInfo() {
        let pageVC = AverageInfoViewController()
        pageVC.modalPresentationStyle = .pageSheet
        
        if let sheetPage = pageVC.sheetPresentationController {
            sheetPage.detents = [.medium(), .large()] // 設定高中等
            sheetPage.prefersGrabberVisible = true   // 顯示上方的小拉條
            sheetPage.preferredCornerRadius = 50    // 圓角設置
        }
        
        present(pageVC, animated: true)
    }
    
    @objc private func cancelKeyboard() {
        view.endEditing(true)
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
            return 60
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
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
            label.backgroundColor = .black
            label.font = .systemFont(ofSize: 24, weight: .semibold)
            label.textColor = .systemPink
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let botton = UIButton(type: .system)
            botton.translatesAutoresizingMaskIntoConstraints = false
            botton.setImage(UIImage(systemName: "questionmark.circle.fill"), for: .normal)
            botton.tintColor = .orange
            botton.addTarget(self, action: #selector(tapAverageInfo), for: .touchUpInside)
            
            AverageHeaderView.addSubview(label)
            AverageHeaderView.addSubview(botton)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: AverageHeaderView.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: AverageHeaderView.trailingAnchor),
                label.topAnchor.constraint(equalTo: AverageHeaderView.topAnchor),
                label.bottomAnchor.constraint(equalTo: AverageHeaderView.bottomAnchor),
                
                botton.topAnchor.constraint(equalTo: AverageHeaderView.topAnchor),
                botton.bottomAnchor.constraint(equalTo: AverageHeaderView.bottomAnchor),
                botton.trailingAnchor.constraint(equalTo: AverageHeaderView.trailingAnchor, constant: -10),
                botton.widthAnchor.constraint(equalToConstant: 40)
            ])

            return AverageHeaderView
        case 1:
            let AverageHeaderView = UIView()
            let label = UILabel()
            label.text = "血糖換算 Glucose Conversion"
            label.backgroundColor = .black
            label.font = .systemFont(ofSize: 24, weight: .semibold)
            label.textColor = .systemYellow
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
            label.backgroundColor = .black
            label.font = .systemFont(ofSize: 24, weight: .semibold)
            label.textColor = .systemGreen
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
            cell.configureData(with: glucoseViewModel.avgbloodGlucose)
            cell.cancellables.removeAll() //防止連續push
            cell.collectionItemTapped.sink { [weak self] title in
                let vc = DetailViewController()
                vc.title = "過去\(title)天血糖"
                self?.navigationController?.setNavigationBarHidden(false, animated: true)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .store(in: &cell.cancellables) //防止連續push
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
