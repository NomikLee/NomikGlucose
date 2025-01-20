//
//  GlucoseNewCollectionViewCell.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/30.
//

import UIKit
import SDWebImage

class GlucoseNewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GlucoseNewCollectionViewCell"
    
    // MARK: - Variables
    
    // MARK: - UI Components
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let newsSources: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(newsImageView)
        newsImageView.addSubview(newsTitle)
        newsImageView.addSubview(newsSources)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            newsTitle.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
            newsTitle.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor),
            newsTitle.heightAnchor.constraint(equalToConstant: 50),
            newsTitle.bottomAnchor.constraint(equalTo: newsSources.topAnchor),
            
            newsSources.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
            newsSources.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor),
            newsSources.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: -50),
            newsSources.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    // MARK: - Functions
    public func configureData(with urlString: String, title: String, sources: String) {
        guard let url = URL(string: urlString) else { return }
        newsImageView.sd_setImage(with: url)
        newsTitle.text = title
        newsSources.text = sources
    }
}
