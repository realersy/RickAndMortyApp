//
//  SectionHeaderView.swift
//  RickAndMortyApp
//
//  Created by Ersan Shimshek on 17.08.2023.
//

import Foundation
import UIKit

final class SectionHeaderView: UICollectionReusableView {
    //MARK: Header identifer
    public static let identifier = "SectionHeaderView"
    
    //MARK: Properties
    let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "GillSans-Bold", size: 17)
        return label
    }()
    //MARK: Configure
    public func configure(text: String){
        categoryTitleLabel.text = text
        addSubview(categoryTitleLabel)
    }
    //MARK: Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryTitleLabel.frame = bounds
    }
}
