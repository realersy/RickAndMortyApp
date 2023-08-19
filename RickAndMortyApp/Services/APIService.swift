//
//  APIService.swift
//  RickAndMortyApp
//
//  Created by Ersan Shimshek on 18.08.2023.
//

import Foundation

final class APIService {
    //MARK: - Singlton property
    public static let shared = APIService()
    
    //MARK: - URL and private init
    private let url = URL(string: "https://rickandmortyapi.com/api/character")
    private init(){}
    
    //MARK: Functions
    //Gets result model
    func getResults(completion: @escaping (Response) -> Void){
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            let model = try! JSONDecoder().decode(Response.self, from: data)
            completion(model)
        }.resume()
    }
    //Gets image of character
    func getImages(urlArray: [String], _ completion: @escaping ([Data]) -> Void) {
        var imagesArray = [Data]()
        let group = DispatchGroup()
        
        for elem in urlArray {
            let request = URLRequest(url: URL(string: elem)!)
            group.enter()
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data else { return }
                imagesArray.append(data)
                group.leave()
            }.resume()
        }
        group.notify(queue: .global()) {
            completion(imagesArray)
        }
    }
    //Gets origin
    func getOrigin(urlOrigin: String, _ completion: @escaping (ExactOrigin) -> Void) {
        guard let urlorigin = URL(string: urlOrigin) else { return }
        let request = URLRequest(url: urlorigin)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            let model = try! JSONDecoder().decode(ExactOrigin.self, from: data)
            completion(model)
        }.resume()
    }
    //Gets episodes array model
    func getEpisodes(urlArray: [String], _ completion: @escaping ([Episode]) -> Void) {
        var episodes = [Episode]()
        let group = DispatchGroup()
        
        for elem in urlArray {
            let request = URLRequest(url: URL(string: elem)!)
            group.enter()
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data else { return }
                let model = try! JSONDecoder().decode(Episode.self, from: data)
                episodes.append(model)
                group.leave()
            }.resume()
        }
        group.notify(queue: .global()) {
            completion(episodes)
        }
    }
    
    func getImage(urlImg: String, _ completion: @escaping (Data) -> Void){
        guard let imageURL = URL(string: urlImg) else { return }
        
        let imageRequest = URLRequest(url: imageURL)
        URLSession.shared.dataTask(with: imageRequest) { data, response, error in
            guard let data = data else { return }
            completion(data)
            
        }.resume()
    }
}

