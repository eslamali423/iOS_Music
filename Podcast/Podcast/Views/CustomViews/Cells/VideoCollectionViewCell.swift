//
//  VideoCollectionViewCell.swift
//  Podcast
//
//  Created by Eslam Ali  on 01/07/2022.
//

import UIKit
import SDWebImage

class VideoCollectionViewCell: UICollectionViewCell {
 
    //MARK:- Vars
    static let identifier = "VideoCollectionViewCell"

    private let videoImageView : UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(systemName: "heart")
        
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()
    
    public let titleLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.text = "album Title"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    public let nameLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.text = "name "
        label.font = .systemFont(ofSize: 18, weight: .bold)
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
        contentView.addSubview(videoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(playImageView)
    }
    
    private func ConfigureConstraints(){
        NSLayoutConstraint.activate([
            videoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            videoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            videoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            playImageView.centerYAnchor.constraint(equalTo: videoImageView.centerYAnchor),
            playImageView.centerXAnchor.constraint(equalTo: videoImageView.centerXAnchor),
            playImageView.widthAnchor.constraint(equalToConstant: 50),
            playImageView.heightAnchor.constraint(equalToConstant: 50),

            nameLabel.bottomAnchor.constraint(equalTo: videoImageView.bottomAnchor,constant: -12),
            nameLabel.leadingAnchor.constraint(equalTo: videoImageView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: videoImageView.trailingAnchor, constant: -8),
            
            titleLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -2),
            titleLabel.leadingAnchor.constraint(equalTo: videoImageView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: videoImageView.trailingAnchor, constant: -8),
        
        ])
    }
    
    //    MARK:- Cell Configuration with Models
        public func configureCell(model : ResponseResult) {
            self.titleLabel.text = model.name
            self.nameLabel.text = model.artistName
            
            let url = URL(string: model.artworkUrl100 )
            self.videoImageView.sd_setImage(with: url, completed: nil)


        }
    
}
