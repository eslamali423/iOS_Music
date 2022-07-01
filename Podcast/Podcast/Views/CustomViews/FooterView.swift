//
//  FooterView.swift
//  Podcast
//
//  Created by Eslam Ali  on 01/07/2022.
//

import UIKit
import RxSwift
import RxCocoa


protocol SongsDelegate : AnyObject {
    func didSelectsong(url : URL)
}

class FooterView: UIView {
    
    //MARK:- Vars
    var songsViewModel = SongsViewModel()
    var disposeBag =  DisposeBag()
    weak var delegate : SongsDelegate?
    
    private let titleLabel : UILabel = {
        let label =  UILabel()
        //  label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Most Played"
        label.font = .systemFont(ofSize: 28, weight: .black)
        
        
        return label
    }()
    
    private let collectionView : UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 180, height: 200)
        
        let collectionView = UICollectionView(frame: .zero,  collectionViewLayout: layout)
        collectionView.register(AlbumsCollectionViewCell.self, forCellWithReuseIdentifier: AlbumsCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    //MARK:- Initlizaers
    init(frame: CGRect, songs:  BehaviorSubject<[ResponseResult]>) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.clipsToBounds = true
        
        addSubview(titleLabel)
        addSubview(collectionView)
        
        
        bindCollectionView(songs: songs)
        collectionView.delegate = self
        //        collectionView.dataSource = self
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK:- Layouts / Constraints
    override func layoutSubviews() {
        super.layoutSubviews()
        //let imageSize: CGFloat = bounds.height
        titleLabel.frame = CGRect(
            x: 20,
            y: 10,
            width: bounds.width,
            height: 40
        )
        collectionView.frame = CGRect(x: 0, y: titleLabel.frame.height + 4, width: bounds.width, height: bounds.height/1.25)
        
    }
    
    
    
    //MARK:- Binding CollectionView
    func bindCollectionView(songs:  BehaviorSubject<[ResponseResult]>){
        songs.bind(to: collectionView.rx.items(cellIdentifier: AlbumsCollectionViewCell.identifier,cellType: AlbumsCollectionViewCell.self)) { row, item, cell in
            
            cell.configureCell(model: item)
            
        }.disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(ResponseResult.self).subscribe(onNext: { [weak self] (model) in
            guard let url = URL(string: model.url) else {
                print("cant get the url")
                
                return}
            print(" get the url")
            
            self?.delegate?.didSelectsong(url: url)
            
        }).disposed(by: disposeBag)
        
        
    }
}


//MARK:- Extension for CollectionView Functions
extension FooterView :  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
}





