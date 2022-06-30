//
//  HeaderView.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import UIKit
import RxSwift
import RxCocoa


class HeaderView: UIView{

   
    //MARK:- Vars
  
    var disposeBag =  DisposeBag()
    
    public let titleLabel : UILabel = {
        let label =  UILabel()
      //  label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Albums"
        label.font = .systemFont(ofSize: 28, weight: .black)

        
        return label
    }()
    
    private let collectionView : UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 180, height: 200)
        
        let collectionView = UICollectionView(frame: .zero,  collectionViewLayout: layout)
        collectionView.register(AlbumsCollectionViewCell.self, forCellWithReuseIdentifier: AlbumsCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
  
  //MARK:- Initlizaers
    init(frame: CGRect, albums:  BehaviorSubject<[Album]>) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.clipsToBounds = true
        
        addSubview(titleLabel)
        addSubview(collectionView)

        
        
        collectionView.delegate = self
//        collectionView.dataSource = self
        
        
        bindCollectionView(albums: albums)
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
            height: 50
        )
        collectionView.frame = CGRect(x: 0, y: titleLabel.frame.height + 4, width: bounds.width, height: bounds.height/1.25)
 
    }
    

    func bindCollectionView(albums:  BehaviorSubject<[Album]>){
        albums.bind(to: collectionView.rx.items(cellIdentifier: AlbumsCollectionViewCell.identifier,cellType: AlbumsCollectionViewCell.self)) { row, item, cell in
            
            cell.configureCell(model: item)
            
        }.disposed(by: disposeBag)
        
        
    }
}

//MARK:- Extension for CollectionView Functions
extension HeaderView :  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 170, height: 200)
      }
    
    }
    
    


