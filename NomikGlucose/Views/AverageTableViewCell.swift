//
//  AverageTableViewCell.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/27.
//

import UIKit
import Combine

class AverageTableViewCell: UITableViewCell {
    
    static let identifier = "AverageTableViewCell"
    
    // MARK: - Variables
    private var glucoseDatas: [GlucoseModel]?
    let collectionItemTapped = PassthroughSubject<String, Never>()
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    private let averageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AverageCollectionViewCell.self, forCellWithReuseIdentifier: AverageCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll() // 清除之前的 Combine 訂閱
    }
    
    // MARK: - UI Setup
    // MARK: - Functions
    public func configureData(with glucoseDatas: [GlucoseModel]){
        self.glucoseDatas = glucoseDatas
        self.glucoseDatas?.sort{ $0.tag < $1.tag } //防止collectionView cell 沒有照順序
        averageCollectionView.reloadData()
    }
}
extension AverageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return glucoseDatas?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AverageCollectionViewCell.identifier, for: indexPath) as? AverageCollectionViewCell else { return UICollectionViewCell() }
        cell.configureAverageData(with: glucoseDatas?[indexPath.item].glucoseDate ?? " ", average: glucoseDatas?[indexPath.item].glucoseDataValue ?? 0.0, color: glucoseDatas?[indexPath.item].glucoseColor ?? .white)
        cell.backgroundColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionItemTapped.send(glucoseDatas?[indexPath.row].glucoseDate ?? "")
    }
}

extension AverageTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: contentView.bounds.height)
    }
}
