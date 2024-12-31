//
//  AverageTableViewCell.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/27.
//

import UIKit

class AverageTableViewCell: UITableViewCell {
    
    static let identifier = "AverageTableViewCell"
    
    // MARK: - Variables
    private var glucoseDatas: [GlucoseModel]?
    
    // MARK: - UI Components
    private let averageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AverageCollectionViewCell.self, forCellWithReuseIdentifier: AverageCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemRed
        contentView.addSubview(averageCollectionView)
        
        averageCollectionView.delegate = self
        averageCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        averageCollectionView.frame = contentView.bounds
    }
    
    // MARK: - UI Setup
    // MARK: - Functions
    public func configureData(with glucoseDatas: [GlucoseModel]){
        self.glucoseDatas = glucoseDatas
        averageCollectionView.reloadData()
    }
}
extension AverageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return glucoseDatas?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AverageCollectionViewCell.identifier, for: indexPath) as? AverageCollectionViewCell else { return UICollectionViewCell() }
        cell.configureAverageData(with: glucoseDatas?[indexPath.row].glucoseDate ?? " ", average: glucoseDatas?[indexPath.row].glucoseDataValue ?? 0.0)
        return cell
    }
}

extension AverageTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: contentView.bounds.height)
    }
}
