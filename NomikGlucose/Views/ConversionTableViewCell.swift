//
//  ConversionTableViewCell.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/31.
//

import UIKit

class ConversionTableViewCell: UITableViewCell {
    
    static let identifier = "ConversionTableViewCell"
    
    // MARK: - Variables
    
    // MARK: - UI Components
    private let mgTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "ex 100.5"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .separator
        textField.font = .systemFont(ofSize: 20, weight: .bold)
        textField.textAlignment = .center
        textField.layer.borderWidth = 2
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.orange.cgColor
        return textField
    }()
    
    private let mgLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "mg/dL"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let changeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrowshape.left.arrowshape.right")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBrown
        return imageView
    }()
    
    private let mmolTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "ex 5.2"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .separator
        textField.font = .systemFont(ofSize: 20, weight: .bold)
        textField.textAlignment = .center
        textField.layer.borderWidth = 2
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.orange.cgColor
        return textField
    }()
    
    private let mmolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "mmol/L"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 50
        contentView.clipsToBounds = true
        contentView.addSubview(mgTextField)
        contentView.addSubview(mgLabel)
        contentView.addSubview(changeImageView)
        contentView.addSubview(mmolTextField)
        contentView.addSubview(mmolLabel)
        
        configureUI()
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            mgTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            mgTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mgTextField.heightAnchor.constraint(equalToConstant: 50),
            mgTextField.widthAnchor.constraint(equalToConstant: 120),
            
            mgLabel.topAnchor.constraint(equalTo: mgTextField.bottomAnchor),
            mgLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mgLabel.leadingAnchor.constraint(equalTo: mgTextField.leadingAnchor),
            mgLabel.trailingAnchor.constraint(equalTo: mgTextField.trailingAnchor),
            
            changeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            changeImageView.leadingAnchor.constraint(equalTo: mgLabel.trailingAnchor, constant: 5),
            changeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            changeImageView.trailingAnchor.constraint(equalTo: mmolTextField.leadingAnchor, constant: -5),
            
            mmolTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            mmolTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mmolTextField.heightAnchor.constraint(equalToConstant: 50),
            mmolTextField.widthAnchor.constraint(equalToConstant: 120),
            
            mmolLabel.topAnchor.constraint(equalTo: mmolTextField.bottomAnchor),
            mmolLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mmolLabel.trailingAnchor.constraint(equalTo: mmolTextField.trailingAnchor),
            mmolLabel.leadingAnchor.constraint(equalTo: mmolTextField.leadingAnchor)
        ])
    }
    
    // MARK: - Functions
    private func configureTextField() {
        mgTextField.addTarget(self, action: #selector(mgEditValue), for: .editingChanged)
        mmolTextField.addTarget(self, action: #selector(mmolEditValue), for: .editingChanged)
    }
    
    // MARK: - Selectors
    @objc private func mgEditValue(_ sender: UITextField) {
        let mmolValue = (Double(sender.text ?? "") ?? 0.0) / 18.0
        let mmolFormatValue = String(format: "%.1f", mmolValue)
        mmolTextField.text = mmolFormatValue
    }
    
    @objc private func mmolEditValue(_ sender: UITextField) {
        let mgValue = (Double(sender.text ?? "") ?? 0.0) * 18.0
        let mgFormatValue = String(format: "%.1f", mgValue)
        mgTextField.text = mgFormatValue
    }
}
