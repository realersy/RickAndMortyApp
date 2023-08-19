//
//  OriginCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Ersan Shimshek on 17.08.2023.
//

import Foundation
import UIKit

final class OriginCell: UICollectionViewCell {
    //MARK: Cell identifier
    static let cellID = "OriginCell"
    
    //MARK: Properties
    private let imageView = UIImageView()
    private let typeLabel = UILabel()
    private let planetLabel = UILabel()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: Setups
extension OriginCell {
    private func setup(){
        
        //View
        layer.cornerRadius = 10
        backgroundColor = UIColor("#262A38")
        
        //ImageView
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "plan")
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 64),
            imageView.widthAnchor.constraint(equalToConstant: 64),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        //Planet Label
        planetLabel.textColor = .white
        planetLabel.font = UIFont(name: "Gilsans", size: 17)
        contentView.addSubview(planetLabel)
        planetLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            planetLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            planetLabel.heightAnchor.constraint(equalToConstant: 22),
            planetLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            planetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        //Planet Text
        typeLabel.textColor = UIColor("#47C60B")
        typeLabel.font = UIFont(name: "Gilsans", size: 13)
        contentView.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            typeLabel.heightAnchor.constraint(equalToConstant: 18),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            typeLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8)
            
        ])
    }
    //MARK: Configure
    func configure(exactOrigin: ExactOrigin){
        planetLabel.text = exactOrigin.name
        typeLabel.text = exactOrigin.type
    }
}
