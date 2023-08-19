//
//  EpisodeCell.swift
//  RickAndMortyApp
//
//  Created by Ersan Shimshek on 19.08.2023.
//

import Foundation
import UIKit

final class EpisodeCell: UICollectionViewCell {
    //MARK: Cell identifer
    public static let cellID = "EpisodeCell"
    
    //MARK: Properties
    private let episodeName = UILabel()
    private let episodeNumber = UILabel()
    private let episodeDate = UILabel()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: Setup
extension EpisodeCell {
    private func setup(){
        
        //Background
        layer.cornerRadius = 10
        backgroundColor = UIColor("#262A38")
        
        //Episode Name
        episodeName.textColor = .white
        episodeName.font = UIFont(name: "Gilsans", size: 17)
        contentView.addSubview(episodeName)
        episodeName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodeName.heightAnchor.constraint(equalToConstant: 22),
            episodeName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            episodeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            episodeName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        episodeNumber.textColor = UIColor("#47C60B")
        episodeNumber.font = UIFont(name: "Gilsans", size: 13)
        contentView.addSubview(episodeNumber)
        episodeNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodeNumber.heightAnchor.constraint(equalToConstant: 18),
            episodeNumber.widthAnchor.constraint(equalToConstant: 119),
            episodeNumber.topAnchor.constraint(equalTo: episodeName.bottomAnchor, constant: 16),
            episodeNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
        
        episodeDate.textColor = UIColor("#93989C")
        episodeDate.font = UIFont(name: "Gilsans", size: 12)
        contentView.addSubview(episodeDate)
        episodeDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodeDate.heightAnchor.constraint(equalToConstant: 16),
            episodeDate.widthAnchor.constraint(equalToConstant: 150),
            episodeDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            episodeDate.centerYAnchor.constraint(equalTo: episodeNumber.centerYAnchor)
        ])
    }
    //MARK: Configure
    func configure(episode: Episode){
        episodeName.text = episode.name
        episodeDate.text = episode.air_date
        episodeNumber.text = episode.episode
    }
}
