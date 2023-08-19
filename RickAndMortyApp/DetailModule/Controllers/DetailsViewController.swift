//
//  DetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Ersan Shimshek on 17.08.2023.
//

import Foundation
import UIKit

//MARK: Section struct
struct Section {
    let name: String
    let objects: [Any]
}

final class DetailsViewController: UIViewController {
    
    //MARK: Properties
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let livingStatus = UILabel()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return collection
    }()
    var sections = [Section]()
    
    var episodes: [Episode]?
    var exactOrigin: ExactOrigin?
    
    //MARK: Injected Properties
    var response: Response?
    var image: UIImage?
    var ip: IndexPath?
    
    //MARK: Custom init
    init(response: Response, image: UIImage, indexPath: IndexPath){
        super.init(nibName: nil, bundle: nil)
        self.ip = indexPath
        self.image = image
        self.response = response
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let sema1 = DispatchSemaphore(value: 0)
        APIService.shared.getEpisodes(urlArray: (response?.results[ip!.row].episode)!) { epis in
            self.episodes = epis
            sema1.signal()
        }
        sema1.wait()
        
        let sema2 = DispatchSemaphore(value: 0)
        if response?.results[ip!.row].origin.url != "" {
            APIService.shared.getOrigin(urlOrigin: (response?.results[ip!.row].origin.url)!) { orig in
                self.exactOrigin = orig
                sema2.signal()
            }
            sema2.wait()
        } else {
            exactOrigin = ExactOrigin(name: "N/A", type: "N/A")
        }
        
        createSections()
        setupNav()
        setupTopComponents()
        setupCollection()
        setupEverything()
    }
}
//MARK: Setups
extension DetailsViewController {
    private func createSections(){
        sections.append(Section(name: "Info", objects: ["Info"]))
        sections.append(Section(name: "Origin", objects: ["Origin"]))
        sections.append(Section(name: "Episodes", objects: episodes!))
    }
    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "chevron-left"),
            style: .plain,
            target: self,
            action: #selector(goBack)
        )
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    private func setupTopComponents(){
        //Background:
        view.backgroundColor = UIColor("#040C1E")
        
        //imageView
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 148),
            imageView.widthAnchor.constraint(equalToConstant: 148),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //nameLabel
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "GillSans", size: 22)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: 250),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //livingStatus
        livingStatus.textAlignment = .center
        livingStatus.textColor = UIColor("#47C60B")
        livingStatus.font = UIFont(name: "GillSans", size: 16)
        livingStatus.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(livingStatus)
        NSLayoutConstraint.activate([
            livingStatus.widthAnchor.constraint(equalToConstant: 100),
            livingStatus.heightAnchor.constraint(equalToConstant: 20),
            livingStatus.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            livingStatus.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupCollection(){
        collectionView.backgroundColor = .clear
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: InfoCell.cellID)
        collectionView.register(OriginCell.self, forCellWithReuseIdentifier: OriginCell.cellID)
        collectionView.register(EpisodeCell.self, forCellWithReuseIdentifier: EpisodeCell.cellID)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: livingStatus.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        ])
    }
    
    private func setupEverything(){
        imageView.image = image
        nameLabel.text = response?.results[ip!.row].name
        livingStatus.text = response?.results[ip!.row].status
        if livingStatus.text == "Dead" {
            livingStatus.textColor = .red
        }
        else if livingStatus.text == "unknown" {
            livingStatus.textColor = .gray
            livingStatus.text = "Unknown"
        }
        
        
    }
}

//MARK: Target func to Go Back
extension DetailsViewController {
    @objc
    func goBack(){
        navigationController?.popViewController(animated: true)
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCell.cellID, for: indexPath) as! InfoCell
            cell.configure(result: (response?.results[ip!.row])!)
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OriginCell.cellID, for: indexPath) as! OriginCell
            cell.configure(exactOrigin: exactOrigin!)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCell.cellID, for: indexPath) as! EpisodeCell
            cell.configure(episode: episodes![indexPath.row])
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
        header.configure(text: sections[indexPath.section].name)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: 50, height: 40+32)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: 327, height: 80)
        }
        else if indexPath.section == 2 {
            return CGSize(width: 327, height: 86)
        }
         
        return CGSize(width: 327, height: 124)
    }
}
