//
//  ListTableViewCell.swift
//  NomikGlucose
//
//  Created by Nomik on 2025/1/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"
    
    // MARK: - Variables
    
    // MARK: - UI Components
    private let listLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    private let listValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.sizeToFit()
        return label
    }()
    
    private let listHasRecord: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "calendar.badge.checkmark")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(listLabel)
        contentView.addSubview(listValueLabel)
        contentView.addSubview(listHasRecord)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            listLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            listLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            listLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            listValueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            listValueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            listValueLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 20),
            listValueLabel.widthAnchor.constraint(equalToConstant: 80),
            
            listHasRecord.topAnchor.constraint(equalTo: contentView.topAnchor),
            listHasRecord.leadingAnchor.constraint(equalTo: listValueLabel.trailingAnchor),
            listHasRecord.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            listHasRecord.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    // MARK: - Functions
    public func configureData(with listText: String, listValue: String, listColor: UIColor, listHasRecordIsHidden: Bool) {
        listHasRecord.isHidden = !listHasRecordIsHidden
        listLabel.text = listText
        listValueLabel.text = listValue
        listValueLabel.backgroundColor = listColor
    }

    // MARK: - Selectors
    
}
