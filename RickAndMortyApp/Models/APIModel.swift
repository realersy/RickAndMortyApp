//
//  APIModel.swift
//  RickAndMortyApp
//
//  Created by Ersan Shimshek on 18.08.2023.
//

import Foundation

struct Response: Codable {
    let results: [Results]
}

struct Results: Codable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let image: String
    let episode: [String]
    
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct ExactOrigin: Codable {
    let name: String
    let type: String
}


struct Episode: Codable {
    let name: String
    let air_date: String
    let episode: String
}
