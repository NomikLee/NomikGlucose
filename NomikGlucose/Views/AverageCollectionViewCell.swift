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
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let averageValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let averageUnit: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "mg/dL"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 30
        contentView.addSubview(averageTitle)
        contentView.addSubview(averageValue)
        contentView.addSubview(averageUnit)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        averageTitle.text = ""
        averageValue.text = ""
    }
    
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            averageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            averageTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            averageTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            averageTitle.heightAnchor.constraint(equalToConstant: 30),
            
            averageValue.leadingAnchor.constraint(equalTo: averageTitle.leadingAnchor),
            averageValue.trailingAnchor.constraint(equalTo: averageTitle.trailingAnchor),
            averageValue.topAnchor.constraint(equalTo: averageTitle.bottomAnchor),
            averageValue.bottomAnchor.constraint(equalTo: averageUnit.topAnchor),
            
            averageUnit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            averageUnit.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            averageUnit.topAnchor.constraint(equalTo: averageValue.bottomAnchor),
            averageUnit.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    // MARK: - Functions
    public func configureAverageData(with dayValue: String, average: Double, color: UIColor) {
        averageTitle.text = "過去\(dayValue)天"
        if average.isNaN {
            averageValue.text = "無量測"
        }else {
            averageValue.text = "\(average)"
        }
        contentView.backgroundColor = color
    }
}
