//
//  InfoCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Ersan Shimshek on 17.08.2023.
//

import Foundation
import UIKit

final class InfoCell: UICollectionViewCell {
    //MARK: Cell identifer
    public static let cellID = "InfoCell"
    
    //MARK: Properties
    private let speciesTextLabel = UILabel()
    private let typeTextLabel = UILabel()
    private let genderTextLabel = UILabel()
    
    private let speciesResultLabel = UILabel()
    private let typeResultLabel = UILabel()
    private let genderResultLabel = UILabel()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 16
        backgroundColor = UIColor("#262A38")
        setupTextLabels()
        setupResultLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setups
extension InfoCell {
    private func setupTextLabels(){
        speciesTextLabel.text = "Species:"
        speciesTextLabel.font = UIFont(name: "GillSans", size: 16)
        speciesTextLabel.textColor = UIColor("#C4C9CE")
        contentView.addSubview(speciesTextLabel)
        speciesTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            speciesTextLabel.heightAnchor.constraint(equalToConstant: 20),
            speciesTextLabel.widthAnchor.constraint(equalToConstant: 64.92),
            speciesTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            speciesTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        typeTextLabel.text = "Type:"
        typeTextLabel.font = UIFont(name: "GillSans", size: 16)
        typeTextLabel.textColor = UIColor("#C4C9CE")
        contentView.addSubview(typeTextLabel)
        typeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            typeTextLabel.heightAnchor.constraint(equalToConstant: 20),
            typeTextLabel.widthAnchor.constraint(equalToConstant: 64.92),
            typeTextLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            typeTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        genderTextLabel.text = "Gender:"
        genderTextLabel.font = UIFont(name: "GillSans", size: 16)
        genderTextLabel.textColor = UIColor("#C4C9CE")
        contentView.addSubview(genderTextLabel)
        genderTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            genderTextLabel.heightAnchor.constraint(equalToConstant: 20),
            genderTextLabel.widthAnchor.constraint(equalToConstant: 64.92),
            genderTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            genderTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupResultLabels(){
        speciesResultLabel.font = UIFont(name: "GillSans", size: 16)
        speciesResultLabel.textColor = .white
        contentView.addSubview(speciesResultLabel)
        speciesResultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            speciesResultLabel.heightAnchor.constraint(equalToConstant: 20),
            speciesResultLabel.widthAnchor.constraint(equalToConstant: 64.92),
            speciesResultLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            speciesResultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        typeResultLabel.font = UIFont(name: "GillSans", size: 16)
        typeResultLabel.textColor = .white
        contentView.addSubview(typeResultLabel)
        typeResultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            typeResultLabel.heightAnchor.constraint(equalToConstant: 20),
            typeResultLabel.widthAnchor.constraint(equalToConstant: 64.92),
            typeResultLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            typeResultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        genderResultLabel.font = UIFont(name: "GillSans", size: 16)
        genderResultLabel.textColor = .white
        contentView.addSubview(genderResultLabel)
        genderResultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            genderResultLabel.heightAnchor.constraint(equalToConstant: 20),
            genderResultLabel.widthAnchor.constraint(equalToConstant: 64.92),
            genderResultLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            genderResultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    //MARK: Configure
    func configure(result: Results) {
        speciesResultLabel.text = result.species
        if result.type == "" {
            typeResultLabel.text = "None"
        } else {
            typeResultLabel.text = result.type
        }
        genderResultLabel.text = result.gender
    }
}
