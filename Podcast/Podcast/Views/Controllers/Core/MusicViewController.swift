//
//  MusicViewController.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import UIKit

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
        view.addSubview(tableView)
        getAlbums()
        configureHeaderView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    
    //MARK:- Navbar Configuration
    
    
    
    //MARK:- Customize Header  for the TableView
    func configureHeaderView()  {
        let  headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 3))
        tableView.tableHeaderView = headerView
        
    }
    
    
    //MARK:- Get All Albums
    func getAlbums()  {
        albumsViewModel.getAlbums { (isSuccess) in
            if isSuccess{
                print("Get Data Successfully")
            }
        }
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
