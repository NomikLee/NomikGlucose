//
//  DietRecordViewController.swift
//  NomikGlucose
//
//  Created by Nomik on 2025/1/22.
//

import UIKit

enum measureTimeIndex: String {
    case morning = "早晨"
    case beforeBreakfast = "早餐前"
    case afterBreakfast = "早餐後"
    case beforeLunch = "午餐前"
    case afterLunch = "午餐後"
    case beforeDinner = "晚餐前"
    case afterDinner = "晚餐後"
    case beforeBed = "睡前"
}

class DietRecordViewController: UIViewController {
    
    private let firebaseViewModel = FirebaseViewModel()
    
    // MARK: - Variables
    private let measureTimeDatas = ["早晨", "早餐前", "早餐後", "午餐前", "午餐後", "晚餐前", "晚餐後", "睡前"]
    private var measureTimeSelect = ""
    
    // MARK: - UI Components
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "食物紀錄"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .systemTeal
        return label
    }()
    
    private let measureTimePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.selectRow(0, inComponent: 0, animated: false)
        return pickerView
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("紀錄", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.systemOrange, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private let foodTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .lightGray
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.font = .systemFont(ofSize: 25, weight: .medium)
        textView.keyboardType = .default
        return textView
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "請輸入您吃的食物..."
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .systemGray
        label.backgroundColor = .clear
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(valueLabel)
        view.addSubview(dateLabel)
        view.addSubview(titleLabel)
        view.addSubview(measureTimePickerView)
        view.addSubview(sendButton)
        view.addSubview(foodTextView)
        foodTextView.addSubview(placeholderLabel)
        
        measureTimePickerView.delegate = self
        measureTimePickerView.dataSource = self
        foodTextView.delegate = self
        
        configureUI()
        setupSendButton()
    }
    
    // MARK: - Functions
    private func setupSendButton() {
        sendButton.addTarget(self, action: #selector(sendFoodData), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    public func configureData(with value: String, color: UIColor , date: String, foodText: [String : String]){ //綁定食物頁面的數據
        valueLabel.text = value
        valueLabel.backgroundColor = color
        dateLabel.text = date
        foodTextView.text = foodText.values.first
        
        if foodTextView.text.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
        
        switch foodText.keys.first {
        case measureTimeIndex.morning.rawValue:
            DispatchQueue.main.async {
                self.measureTimePickerView.selectRow(0, inComponent: 0, animated: true)
            }
        case measureTimeIndex.beforeBreakfast.rawValue:
            DispatchQueue.main.async {
                self.measureTimePickerView.selectRow(1, inComponent: 0, animated: true)
            }
        case measureTimeIndex.afterBreakfast.rawValue:
            DispatchQueue.main.async {
                self.measureTimePickerView.selectRow(2, inComponent: 0, animated: true)
            }
        case measureTimeIndex.beforeLunch.rawValue:
            DispatchQueue.main.async {
                self.measureTimePickerView.selectRow(3, inComponent: 0, animated: true)
            }
        case measureTimeIndex.afterLunch.rawValue:
            DispatchQueue.main.async {
                self.measureTimePickerView.selectRow(4, inComponent: 0, animated: true)
            }
        case measureTimeIndex.beforeDinner.rawValue:
            DispatchQueue.main.async {
                self.measureTimePickerView.selectRow(5, inComponent: 0, animated: true)
            }
        case measureTimeIndex.afterDinner.rawValue:
            DispatchQueue.main.async {
                self.measureTimePickerView.selectRow(6, inComponent: 0, animated: true)
            }
        case measureTimeIndex.beforeBed.rawValue:
            DispatchQueue.main.async {
                self.measureTimePickerView.selectRow(7, inComponent: 0, animated: true)
            }
        default:
            break
        }
    }
    
    // MARK: - Selectors
    @objc func sendFoodData() {
        guard let foodText = foodTextView.text else { return }
        guard let date = dateLabel.text else { return }
        
        if measureTimeSelect == "" { //measure預設為第一個選項
            measureTimeSelect = measureTimeDatas[0]
        }
        firebaseViewModel.setFirebaseData(to: date, measureTimeSelect: measureTimeSelect, foodText: foodText)
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: view.topAnchor),
            valueLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 100),
            
            dateLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 35),
            
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 45),
            
            measureTimePickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            measureTimePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            measureTimePickerView.widthAnchor.constraint(equalToConstant: 320),
            measureTimePickerView.heightAnchor.constraint(equalToConstant: 100),
            
            sendButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            sendButton.leadingAnchor.constraint(equalTo: measureTimePickerView.trailingAnchor, constant: 5),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            sendButton.bottomAnchor.constraint(equalTo: measureTimePickerView.bottomAnchor),
            
            foodTextView.topAnchor.constraint(equalTo: measureTimePickerView.bottomAnchor, constant: 5),
            foodTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            foodTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            foodTextView.heightAnchor.constraint(equalToConstant: 130),
            
            placeholderLabel.topAnchor.constraint(equalTo: foodTextView.topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: foodTextView.leadingAnchor, constant: 8),
        ])
    }
}
// MARK: - Extension
extension DietRecordViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return measureTimeDatas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return measureTimeDatas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        measureTimeSelect = measureTimeDatas[row]
    }
}

extension DietRecordViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {//編輯開始時關閉placeholderLabel
        placeholderLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) { //偵測編輯結束時有無文字來顯示placeholderLabel
        if textView.text.isEmpty {
            placeholderLabel.isHidden = false
        }else {
            placeholderLabel.isHidden = true
        }
    }
}
