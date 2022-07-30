//
//  MusicViewController.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD
import SafariServices

class MusicViewController: UIViewController {
    
    //MARK:- Vars
    var albumsViewModel = AlbumsViewModel()
    var songsViewModel = SongsViewModel()
    var podcastviewmodel = PodcastsViewModel()
    
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
        configureNavBar()
        view.addSubview(tableView)
        
        tableView.isHidden = true
        
        showProgress()
        getAlbums()
        getSongs()
       
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    
    //MARK:- Navbar Configuration
    func configureNavBar()  {
        
        // set the logo in the center
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //  imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(systemName: "applelogo", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        
        let contentView = UIView()
        self.navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        // set the left buton to the navBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: nil)
        
        // set the left buton to the navBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .done, target: self, action: nil)
        
        
        navigationController?.navigationBar.tintColor = .systemPink
    }
    
    //MARK:- Customize Header  for the TableView
    func configureHeaderView(albums : BehaviorSubject<[ResponseResult]>)  {
        let  headerView = AlbumsHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 3), albums: albums)
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        
    }
    
    //MARK:- Customize Footter  for the TableView
    func configureFooterView(songs : BehaviorSubject<[ResponseResult]>)  {
        let  footterView = SongsFooterView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), songs: songs)
        footterView.delegate = self
        tableView.tableFooterView = footterView
        
    }
    
    //MARK:- Get All Albums
    func getAlbums()  {
        albumsViewModel.getAlbums { [weak self ](isSuccess) in
            if isSuccess{
                guard self == self else {return }
                self?.configureHeaderView(albums: self!.albumsViewModel.albumsBehaviorSubject)
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
                ProgressHUD.dismiss()
            }
        }
    }
    
    //MARK:- get Songs Data
    private func getSongs(){
        songsViewModel.getSongs { [weak self ](isSuccess) in
            if isSuccess{
                guard self == self else {return }
                self?.configureFooterView(songs: self!.songsViewModel.songsBehaviorSubject)
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
                ProgressHUD.dismiss()
            }
        }
    }
    //MARK:- Customize Loading Indicator
    private func showProgress(){
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.colorAnimation = .systemPink
        ProgressHUD.show()
    }
}

//MARK:- extension for TableView delegate and datasource
extension MusicViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {return  UITableViewCell()}
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}
//MARK:- extension for Albums delegate
extension MusicViewController : AlbumsDelegate {
    func didSelectAlbum(url: URL) {
        let albumVC =  SFSafariViewController(url: url)
        present(albumVC, animated: true, completion: nil)
    }
    
    
}

//MARK:- extension for Video delegate
extension MusicViewController : VideoDelegate {
    func didSelectVideo(url: URL) {
        let videoVC =  SFSafariViewController(url: url)
        present(videoVC, animated: true, completion: nil)
    }
}

//MARK:- extension for Songs delegate
extension MusicViewController : SongsDelegate {
    func didSelectsong(url: URL) {
        let songVC =  SFSafariViewController(url: url)
        present(songVC, animated: true, completion: nil)
    }
    
    
    
    
}
