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
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
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
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    public let nameLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "name "
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.adjustsFontSizeToFitWidth = false
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
        contentView.addSubview(nameLabel)
        
        
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
            albumImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),


            titleLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor,constant: 1),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 1),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
   
        ])
    }
    
//    MARK:- Cell Configuration with Models
    public func configureCell(model : ResponseResult) {
        self.titleLabel.text = model.name
        self.nameLabel.text = model.artistName
        
        let url = URL(string: model.artworkUrl100 )
        self.albumImageView.sd_setImage(with: url, completed: nil)


    }
    
  
  
  
    
    
    
    
}
