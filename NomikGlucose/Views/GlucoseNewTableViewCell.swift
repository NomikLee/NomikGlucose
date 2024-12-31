//
//  GlucoseNewTableViewCell.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/31.
//

import UIKit
import Combine

class GlucoseNewTableViewCell: UITableViewCell {
    
    static let identifier = "GlucoseNewTableViewCell"
    
    // MARK: - Variables
    private var newsDatas: NewsModel?
    var newsItemSelected = PassthroughSubject<String, Never>()
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GlucoseNewCollectionViewCell.self, forCellWithReuseIdentifier: GlucoseNewCollectionViewCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    // MARK: - UI Setup
    
    // MARK: - Functions
    public func configureData(with newsDatas: NewsModel) {
        self.newsDatas = newsDatas
        collectionView.reloadData()
    }
}
// MARK: - Extension
extension GlucoseNewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsDatas?.articles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlucoseNewCollectionViewCell.identifier, for: indexPath) as? GlucoseNewCollectionViewCell else { return UICollectionViewCell() }
        cell.configureData(with: newsDatas?.articles[indexPath.row].urlToImage ?? "", title: newsDatas?.articles[indexPath.row].title ?? "", sources: newsDatas?.articles[indexPath.row].source.name ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItemUrl = newsDatas?.articles[indexPath.row].url else { return }
        newsItemSelected.send(selectedItemUrl) //傳遞新聞網址
    }
}

extension GlucoseNewTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: contentView.bounds.width, height: contentView.bounds.height)
    }
}
