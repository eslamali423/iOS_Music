//
//  AlbumsCollectionViewCell.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import UIKit
import SDWebImage

class AlbumsCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Vars
    static let identifier = "AlbumsCollectionViewCell"

    private let albumImageView : UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "heart")
        
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()
    
    public let titleLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.text = "album Title"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    //MARK:- Initilizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        setupLayouts()
        ConfigureConstraints()
    }
    

    required init?(coder: NSCoder) {
        fatalError()
    }
  //MARK:- Layouts / Constraints
    private func setupLayouts(){
        
       
        contentView.addSubview(albumImageView)
        contentView.addSubview(titleLabel)
       
//        contentView.layer.borderWidth = 0.5
//        contentView.layer.cornerRadius = 15
//        contentView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.3
        
    }
    
    private func ConfigureConstraints(){
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            albumImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            albumImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),


            titleLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor,constant: 1),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

   
        ])
    }
    
//    MARK:- Cell Configuration with Models
    public func configureCell(model : Album) {
        self.titleLabel.text = model.artistName
        let url = URL(string: model.artworkUrl100 )
        self.albumImageView.sd_setImage(with: url, completed: nil)


    }
    
  
  
  
    
    
    
    
}
