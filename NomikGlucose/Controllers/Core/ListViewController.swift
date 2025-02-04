//
//  ListViewController.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/27.
//

import UIKit
import Combine

class ListViewController: UIViewController {
    
    // MARK: - Variables
    private let glucoseViewModel = GlucoseViewModel()
    private let firebaseViewModel = FirebaseViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    private let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private lazy var listlHeaderView: ListHeaderView = {
        let headerView = ListHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 300))
        return headerView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(listTableView)
        
        listTableView.tableHeaderView = listlHeaderView
        
        listTableView.dataSource = self
        listTableView.delegate = self
        
        bindView()
        refreshList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listTableView.frame = view.bounds
    }
    
    
    // MARK: - Functions
    private func bindView() {
        glucoseViewModel.fetchGlucoseData()
        firebaseViewModel.getFirebaseData()
        
        listlHeaderView.bindView(to: glucoseViewModel.$allBloodGlucose.eraseToAnyPublisher())
        
        firebaseViewModel.$getData.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.listTableView.reloadData()
            }
            .store(in: &cancellables)
        
        glucoseViewModel.$allBloodGlucose.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.listTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func refreshList() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        listTableView.refreshControl = refresh
    }
    
    // MARK: - Selectors
    @objc func refreshData(){
        cancellables.removeAll()
        glucoseViewModel.allBloodGlucose.removeAll() //清除allBloodGlucose的數據
        bindView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.listTableView.refreshControl?.endRefreshing()
        }
    }
}
// MARK: - Extension
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if glucoseViewModel.allBloodGlucose.count == 0 {
            return 1
        }
        return glucoseViewModel.allBloodGlucose.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if glucoseViewModel.allBloodGlucose.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "無血糖數據資料"
            cell.textLabel?.font = .systemFont(ofSize: 30, weight: .medium)
            cell.textLabel?.textColor = .secondaryLabel
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
            
            
            cell.configureData(with: "\(glucoseViewModel.allBloodGlucose[indexPath.row].glucoseDate)", listValue: "\(glucoseViewModel.allBloodGlucose[indexPath.row].glucoseDataValue)", listColor: glucoseViewModel.allBloodGlucose[indexPath.row].glucoseColor, listHasRecordIsHidden: firebaseViewModel.getData.keys.contains(glucoseViewModel.allBloodGlucose[indexPath.row].glucoseDate))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if glucoseViewModel.allBloodGlucose.count == 0 {
            return
        }else {
            let pageVc = DietRecordViewController()
            pageVc.configureData(with: "\(glucoseViewModel.allBloodGlucose[indexPath.row].glucoseDataValue)", color: glucoseViewModel.allBloodGlucose[indexPath.row].glucoseColor, date: glucoseViewModel.allBloodGlucose[indexPath.row].glucoseDate, foodText: firebaseViewModel.getData[glucoseViewModel.allBloodGlucose[indexPath.row].glucoseDate] ?? [:])
            pageVc.modalPresentationStyle = .pageSheet
            
            if let sheet = pageVc.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 50
            }
            present(pageVc, animated: true)
        }
    }
}
