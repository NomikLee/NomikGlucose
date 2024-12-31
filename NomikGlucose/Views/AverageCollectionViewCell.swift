//
//  AverageCollectionViewCell.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/27.
//

import UIKit

class AverageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AverageCollectionViewCell"
    
    // MARK: - Variables
    
    // MARK: - UI Components
    private let averageTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .systemBackground
        return label
    }()
    
    private let averageValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .systemBackground
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemOrange
        contentView.layer.cornerRadius = 30
        contentView.addSubview(averageTitle)
        contentView.addSubview(averageValue)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            averageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            averageTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            averageTitle.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -5),
            averageTitle.heightAnchor.constraint(equalToConstant: 30),
            
            averageValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            averageValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            averageValue.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5),
            averageValue.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    // MARK: - Functions
    public func configureAverageData(with dayValue: String, average: Double) {
        averageTitle.text = "過去\(dayValue)天"
        averageValue.text = "\(average) mg/dL"
    }
}
