//
//  SongsCollectionViewCell.swift
//  Podcast
//
//  Created by Eslam Ali  on 01/07/2022.
//

import UIKit
import SDWebImage

class SongsCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Vars
    static let identifier = "SongsCollectionViewCell"
    
    private let songImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(systemName: "heart")
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    public let titleLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .label
        label.textAlignment = .left
        label.text = "album Title"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    public let nameLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.text = "name "
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    private let playImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "play.circle.fill")
        image.tintColor = .systemPink
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
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
        contentView.addSubview(songImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(playImageView)
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.3
    }
    
    private func ConfigureConstraints(){
        NSLayoutConstraint.activate([
            songImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            songImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            songImageView.widthAnchor.constraint(equalToConstant: 50),
            songImageView.heightAnchor.constraint(equalToConstant: 50),
            
            
            playImageView.centerYAnchor.constraint(equalTo: songImageView.centerYAnchor),
            playImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            playImageView.widthAnchor.constraint(equalToConstant: 20),
            playImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: songImageView.topAnchor,constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: playImageView.leadingAnchor, constant: -8),
            
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            nameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor ),
            nameLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
        ])
    }
    
    //    MARK:- Cell Configuration with Models
    public func configureCell(model : ResponseResult) {
        self.titleLabel.text = model.name
        self.nameLabel.text = model.artistName
        
        let url = URL(string: model.artworkUrl100 )
        self.songImageView.sd_setImage(with: url, completed: nil)
        
        
    }
    
}
