//
//  StartedViewController.swift
//  NomikGlucose
//
//  Created by Nomik on 2025/2/3.
//

import UIKit

class StartedViewController: UIViewController {
    
    // MARK: - Variables
    private let startImageName: [String] = ["主頁", "燈號", "AI血糖分析", "血糖清單", "上傳頁面"]
    private let startInfo: [String] = [
        "監控您的血糖，從最新數值到平均趨勢，單位換算和最新資訊一手掌握！",
        "顏色燈號顯示血糖值範圍，輕鬆掌握您的血糖健康狀況！",
        "AI分析幫您掌握血糖健康！",
        "血糖趨勢變化一目瞭然，助您維持健康生活！",
        "記錄三餐血糖變化，搭配食物紀錄，做到正確血糖管理！"
    ]
    
    var currentPageNum: Int = 0 { // 用didSet去更動pageControl的點位置
        didSet {
            pageControl.currentPage = currentPageNum
            if currentPageNum == 4 {
                enterButton.isHidden = false
            }else {
                enterButton.isHidden = true
            }
        }
    }
    
    // MARK: - UI Components
    private let startCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(StartedCollectionViewCell.self, forCellWithReuseIdentifier: StartedCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("略過", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.darkGray, for: .normal)
        return button
    }()
    
    private let enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("進入", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.tintColor = .black
        button.backgroundColor = UIColor(red: 136/255, green: 204/255, blue: 218/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.isHidden = true
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        page.currentPage = 0
        page.numberOfPages = 5
        page.currentPageIndicatorTintColor = .black
        page.pageIndicatorTintColor = .gray
        return page
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 194/256, green: 142/256, blue: 145/238, alpha: 1)
        view.addSubview(startCollectionView)
        view.addSubview(skipButton)
        view.addSubview(enterButton)
        view.addSubview(pageControl)
        
        startCollectionView.delegate = self
        startCollectionView.dataSource = self
        
        skipButton.addTarget(self, action: #selector(skipHomeView), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(enterHomeView), for: .touchUpInside)
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Functions
    private func configureUI() {
        NSLayoutConstraint.activate([
            startCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), //做到全覆蓋
            startCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            startCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            startCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            skipButton.heightAnchor.constraint(equalToConstant: 50),
            skipButton.widthAnchor.constraint(equalToConstant: 50),
            
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            
            enterButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.heightAnchor.constraint(equalToConstant: 50),
            enterButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // MARK: - Selectors
    @objc func enterHomeView() {
        UserDefaults.standard.set(true, forKey: "enterTheMark") //當進入過主頁後在enterTheMark設定true來當標記 可以跳過說明頁面
        
        let vc = MainTabbarController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func skipHomeView() {
        UserDefaults.standard.set(true, forKey: "enterTheMark") //當進入過主頁後在enterTheMark設定true來當標記 可以跳過說明頁面
        
        let vc = MainTabbarController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}

// MARK: - Extension
extension StartedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return startImageName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartedCollectionViewCell.identifier, for: indexPath) as? StartedCollectionViewCell else { return UICollectionViewCell() }
        cell.configureData(with: startImageName[indexPath.row], info: startInfo[indexPath.row])
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = startCollectionView.frame.width
        currentPageNum = Int(round(scrollView.contentOffset.x / pageWidth))
    }
}

extension StartedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height)
    }
}
