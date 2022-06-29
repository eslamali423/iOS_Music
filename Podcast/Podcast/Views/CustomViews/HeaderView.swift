//
//  HeaderView.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import UIKit


class HeaderView: UIView{

   
    //MARK:- Vars
  
    public let titleLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Albums"
        return label
    }()
    
    private let collectionView : UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 140)
        
        let collectionView = UICollectionView(frame: .zero,  collectionViewLayout: layout)
        collectionView.register(AlbumsCollectionViewCell.self, forCellWithReuseIdentifier: AlbumsCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.semanticContentAttribute = .forceRightToLeft
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false


        return collectionView
    }()
    

   
    
  //MARK:- Initlizaers
   override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        self.clipsToBounds = true
        
        addSubview(titleLabel)
        addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    //MARK:- Layouts / Constraints
    override func layoutSubviews() {
        super.layoutSubviews()
        //let imageSize: CGFloat = bounds.height
        titleLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: 50
        )
        collectionView.frame = CGRect(x: 0, y: titleLabel.frame.height + 10, width: bounds.width - 10, height: bounds.height/2)
 
    }
    

    
}

//MARK:- Extension for CollectionView Functions
extension HeaderView :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: AlbumsCollectionViewCell.identifier, for: indexPath) as? AlbumsCollectionViewCell
        else {
            print("can't get category cell")
            return UICollectionViewCell()
        }
        
       
        return cell
                
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 120, height: 140)
      }
    
    }
    
    


