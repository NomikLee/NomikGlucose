//
//  HomeHeaderView.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/27.
//

import UIKit

class HomeHeaderView: UIView {
    
    // MARK: - Variables
    let gradientLayer = CAGradientLayer()
    
    // MARK: - UI Components
    private let glucoseTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "最新血糖"
        return label
    }()
    
    private let glucoseLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemMint
        addSubview(glucoseTitleLabel)
        addSubview(glucoseLable)
        
        configureUI()
        configureGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    // MARK: - UI Setup
    private func configureUI(){
        NSLayoutConstraint.activate([
            glucoseTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            glucoseTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            glucoseTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            glucoseTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            glucoseLable.topAnchor.constraint(equalTo: glucoseTitleLabel.bottomAnchor, constant: 20),
            glucoseLable.leadingAnchor.constraint(equalTo: leadingAnchor),
            glucoseLable.trailingAnchor.constraint(equalTo: trailingAnchor),
            glucoseLable.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: - Functions
    public func configureData(to glucoseData: Double) {
        glucoseLable.text = "\(glucoseData) mg/dL"
    }
    
    private func configureGradientLayer() {
        gradientLayer.colors = [
            UIColor(red: 0.6, green: 0.9, blue: 0.6, alpha: 1).cgColor, // 淺綠色
            UIColor(red: 0.1, green: 0.6, blue: 0.1, alpha: 1).cgColor  // 深綠色
        ]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0) // 頂部
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)   // 底部

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
