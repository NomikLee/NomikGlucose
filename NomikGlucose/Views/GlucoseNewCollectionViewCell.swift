//
//  GlucoseNewCollectionViewCell.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/30.
//

import UIKit

class GlucoseNewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GlucoseNewCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
