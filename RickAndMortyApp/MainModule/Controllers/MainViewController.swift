//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Ersan Shimshek on 17.08.2023.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: Properties
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return collection
    }()
    
    var retrievedResponse: Response?
    var imagesArray = [UIImage]()
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let semaphore1 = DispatchSemaphore(value: 0)

        APIService.shared.getResults { resp in
            self.retrievedResponse = resp
            semaphore1.signal()
        }
        semaphore1.wait()
        
        let semaphore2 = DispatchSemaphore(value: 0)
        for result in (retrievedResponse?.results)! {
            APIService.shared.getImage(urlToImage: result.image) { data in
                self.imagesArray.append(UIImage(data: data)!)
                semaphore2.signal()
            }
        }
        
        semaphore2.wait()
        setupNav()
        setupCollectionView()
    }
    
}
//MARK: Setups
extension MainViewController {
    private func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor("#040C1E")
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.cellID)
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func setupNav(){
        title = "Characters"
    }
}
//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return retrievedResponse?.results.count ?? 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.cellID, for: indexPath) as! CustomCollectionViewCell
        cell.configureLabelText(name: retrievedResponse?.results[indexPath.row].name ?? "nil")
        cell.configureImage(imageArray: imagesArray, indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        
        let detailsVC = DetailsViewController(response: retrievedResponse!, image: cell.getImage()!, indexPath: indexPath)
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 156, height: 202)
    }
}
