//
//  StartedCollectionViewCell.swift
//  NomikGlucose
//
//  Created by Nomik on 2025/2/4.
//

import UIKit

class StartedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "StartedCollectionViewCell"
    
    // MARK: - Variables
    
    // MARK: - UI Components
    private let infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 194/256, green: 142/256, blue: 145/238, alpha: 1)
        contentView.addSubview(infoImageView)
        contentView.addSubview(infoLabel)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    public func configureData(with imageName: String, info: String) {
        infoImageView.image = UIImage(named: imageName)
        infoLabel.text = info
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            infoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            infoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100),
            infoImageView.heightAnchor.constraint(equalToConstant: 200),
            infoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -180),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            infoLabel.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
}
