//
//  PodcastViewController.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import UIKit
import RxCocoa
import RxSwift
import SafariServices

class PodcastViewController: UIViewController {

    //MARK:- Vars
    var podcastViewModel = PodcastsViewModel()
    
    var disposeBag = DisposeBag()
  
    private let collectionView : UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 180, height: 200)
        
        let collectionView = UICollectionView(frame: .zero,  collectionViewLayout: layout)
        collectionView.register(SongsCollectionViewCell.self, forCellWithReuseIdentifier: SongsCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        getPodcasts()
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    
    //MARK:- Customize Header  for the TableView
    func configureHeaderView(podcasts : BehaviorSubject<[ResponseResult]>)  {
        let  headerView = PodcastsHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2.5), podcasts: podcasts)
        headerView.delegate = self
        
      //  collectionView.register(PodcastsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader ,withReuseIdentifier: "cell")
        
    }
    
    
    //MARK:- Get Podcasts Data
    private func getPodcasts(){
        podcastViewModel.getPodcasts { [weak self ](isSuccess) in
            if isSuccess{
                print("get data in virw controller ")
               self?.configureHeaderView(podcasts: self!.podcastViewModel.pdocastBehaviorSubject)
                self?.collectionView.reloadData()
            }
        }
    }


}

//MARK:- extension for tableView
extension PodcastViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    
    
}

//MARK:- extension for PodcastDelegate
extension PodcastViewController : PodcastsDelegate {
    func didSelectPodcast(url: URL) {
        let songVC =  SFSafariViewController(url: url)
        present(songVC, animated: true, completion: nil)
    }
}
