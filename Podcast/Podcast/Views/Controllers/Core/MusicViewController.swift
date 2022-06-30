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
    func configureHeaderView(albums : BehaviorSubject<[Album]>)  {
        let  headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2.7), albums: albums)
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        
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
    
    private func showProgress(){
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.colorAnimation = .systemPink
        ProgressHUD.show()
    }
    

}

//MARK:- extension for TableView delegate and datasource
extension MusicViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
//MARK:- extension for Albums delegate
extension MusicViewController : AlbumsDelegate {
    func didSelectAlbum(url: URL) {
        let albumVC =  SFSafariViewController(url: url)
        albumVC.navigationController?.title = "sdfsdfsdf"
        present(albumVC, animated: true, completion: nil)
    }
    
    
}
