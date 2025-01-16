//
//  AverageInfoViewController.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2025/1/3.
//

import UIKit

class AverageInfoViewController: UIViewController {
    
    // MARK: - Variables
    // MARK: - UI Components
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "數值燈號指示"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let glucoseExtraHigh: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "數值超過 160 mg/dL"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .orange
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        return label
    }()
    
    private let glucoseHigh: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "數值 130 ~ 160 mg/dL"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .systemYellow
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        return label
    }()
    
    private let glucoseNormal: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "數值 80 ~ 130 mg/dL"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .systemGreen
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        return label
    }()
    
    private let glucoseLow: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "數值低於 80 mg/dL"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .systemRed
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        return label
    }()
    
    private let glucoseInfoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "血糖標準")
        return imageView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(titlelabel)
        view.addSubview(glucoseExtraHigh)
        view.addSubview(glucoseHigh)
        view.addSubview(glucoseNormal)
        view.addSubview(glucoseLow)
        view.addSubview(glucoseInfoImageView)
        
        configureUI()
    }

    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            titlelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titlelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titlelabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titlelabel.heightAnchor.constraint(equalToConstant: 40),
            
            glucoseExtraHigh.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            glucoseExtraHigh.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            glucoseExtraHigh.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 30),
            glucoseExtraHigh.heightAnchor.constraint(equalToConstant: 50),
            
            glucoseHigh.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            glucoseHigh.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            glucoseHigh.topAnchor.constraint(equalTo: glucoseExtraHigh.bottomAnchor, constant: 30),
            glucoseHigh.heightAnchor.constraint(equalToConstant: 50),
            
            glucoseNormal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            glucoseNormal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            glucoseNormal.topAnchor.constraint(equalTo: glucoseHigh.bottomAnchor, constant: 30),
            glucoseNormal.heightAnchor.constraint(equalToConstant: 50),
            
            glucoseLow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            glucoseLow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            glucoseLow.topAnchor.constraint(equalTo: glucoseNormal.bottomAnchor, constant: 30),
            glucoseLow.heightAnchor.constraint(equalToConstant: 50),
            
            glucoseInfoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            glucoseInfoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            glucoseInfoImageView.topAnchor.constraint(equalTo: glucoseLow.bottomAnchor, constant: 15),
            glucoseInfoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - Functions
    
    // MARK: - Selectors
}
