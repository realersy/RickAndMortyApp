//
//  CustomCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Ersan Shimshek on 17.08.2023.
//

import Foundation
import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    //MARK: Cell identifer
    public static let cellID = "CustomCollectionViewCell"
    
    //MARK: Properties
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: prepareForReuse
    override func prepareForReuse() {
        imageView.image = nil
        nameLabel.text = nil
    }
}
//MARK: Setup
extension CustomCollectionViewCell {
    private func setup(){
        
        //ContentView
        layer.cornerRadius = 16
        backgroundColor = UIColor("#262A38")
        
        //ImageView
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        //NameLabel
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.text = "Rick Sanchez"
        nameLabel.font = UIFont(name: "GillSans", size: 17)
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 29),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -29),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    //MARK: Configure Labels and Images
    func configureImage(imageData: Data){
        imageView.image = UIImage(data: imageData)
    }
    func configureLabelText(name: String){
        nameLabel.text = name
    }
    
    func getImage() -> UIImage? {
        return imageView.image
    }
}
