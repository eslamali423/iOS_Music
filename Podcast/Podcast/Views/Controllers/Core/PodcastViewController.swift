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
  
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        getPodcasts()
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    //MARK:- Customize Header  for the TableView
    func configureHeaderView(podcasts : BehaviorSubject<[ResponseResult]>)  {
        let  headerView = PodcastsHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2.5), albums: podcasts)
     //   headerView.delegate = self
        tableView.tableHeaderView = headerView
       
    }
    
  
    
    
    //MARK:- Get Podcasts Data
    private func getPodcasts(){
        podcastViewModel.getPodcasts { [weak self ](isSuccess) in
            if isSuccess{
                print("get data in virw controller ")
               self?.configureHeaderView(podcasts: self!.podcastViewModel.pdocastBehaviorSubject)
                self?.tableView.reloadData()
            }
        }
    }


}

//MARK:- extension for TableView delegate and datasource
extension PodcastViewController : UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}


    
   

