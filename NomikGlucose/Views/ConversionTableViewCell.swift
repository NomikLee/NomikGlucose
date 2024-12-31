//
//  ConversionTableViewCell.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/31.
//

import UIKit

class ConversionTableViewCell: UITableViewCell {
    
    static let identifier = "ConversionTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
