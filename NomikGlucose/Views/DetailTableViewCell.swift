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
        label.text = "這個數值通常表明您的糖尿病控制不佳，需要立即採取行動。可能的影響：糖尿病併發症的風險增加：長期高血糖會損害您的血管和器官，增加患以下疾病的風險：心血管疾病： 包括冠狀動脈疾病、中風和外周動脈疾病。腎臟疾病：可能導致腎衰竭。神經損傷：導致神經病變，例如麻木、刺痛和疼痛。眼睛損傷： 可能導致視力模糊、白內障和青光眼。 足部潰瘍和感染：  可能需要截肢。建議：您需要立即尋求醫療專業人士的幫助。 以下是一些建議，但不應取代醫生或其他醫療專業人員的診斷和治療方案：立即諮詢您的醫生或糖尿病專科醫生：  他們會進行全面的評估，確定您的糖尿病類型（1型或2型），並制定適合您的治療計劃。調整生活方式：這是控制血糖的關鍵。這包括：飲食調整： 遵循糖尿病友善飲食，注重低血糖指數食物，控制碳水化合物攝入量，增加蔬菜、水果和纖維的攝入。規律運動：每天至少進行 30 分鐘的中等強度運動，例如快走、游泳或騎自行車。 體重管理：如果超重或肥胖，減重可以顯著改善血糖控制。服藥：您的醫生可能會根據您的病情開具藥物，例如口服降糖藥或胰島素，以幫助您控制血糖。血糖監測： 定期監測血糖，以便及時調整治療方案。教育：學習有關糖尿病的知識，了解如何更好地管理病情。重要提醒：血糖平均值 202 mg/dL 是一個嚴重的問題，需要專業醫療干預。 不要延誤就醫。  及早診斷和治療可以幫助您降低糖尿病併發症的風險，並改善您的生活質量。  立即聯繫您的醫生或尋求醫療協助。"
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
