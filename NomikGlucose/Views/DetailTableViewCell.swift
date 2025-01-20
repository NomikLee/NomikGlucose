//
//  DetailTableViewCell.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2025/1/7.
//

import UIKit
import Combine

class DetailTableViewCell: UITableViewCell {
    
    static let identifier = "DetailTableViewCell"
    
    // MARK: - Variables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    private let aiImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "timelapse")
        iv.backgroundColor = .darkText
        return iv
    }()
    
    private let aiTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AI分析"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .systemYellow
        label.backgroundColor = .darkText
        return label
    }()
    
    private let aiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = .darkText
        return label
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(aiImageView)
        contentView.addSubview(aiTitleLabel)
        contentView.addSubview(aiLabel)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    public func configureData(with feedback: String) {
        aiLabel.text = "\(feedback)"
    }
    
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            aiImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            aiImageView.widthAnchor.constraint(equalToConstant: 50),
            aiImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            aiImageView.heightAnchor.constraint(equalToConstant: 50),
            
            aiTitleLabel.leadingAnchor.constraint(equalTo: aiImageView.trailingAnchor),
            aiTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            aiTitleLabel.topAnchor.constraint(equalTo: aiImageView.topAnchor),
            aiTitleLabel.bottomAnchor.constraint(equalTo: aiImageView.bottomAnchor),
            
            aiLabel.topAnchor.constraint(equalTo: aiImageView.bottomAnchor, constant: 10),
            aiLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            aiLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            aiLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
}
