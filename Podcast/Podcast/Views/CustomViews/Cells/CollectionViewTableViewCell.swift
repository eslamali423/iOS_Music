//
//  CollectionViewTableViewCell.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol VideoDelegate : AnyObject {
    func didSelectVideo ( url: URL)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    //MARK:- Vars
    static let identifier = "CollectionViewTableViewCell"
    var videosViewModel = VideoViewModel()
    var disposeBag = DisposeBag()
    weak var delegate : VideoDelegate?
    
    private let titleLabel : UILabel = {
        let label =  UILabel()
        //  label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Music Videos"
        label.font = .systemFont(ofSize: 28, weight: .black)
        label.backgroundColor = .clear
        return label
    }()
    
    private let collectionView : UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //   layout.itemSize = CGSize(width: 370, height: 300)
        
        let collectionView = UICollectionView(frame: .zero,  collectionViewLayout: layout)
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    //MARK:- Life Cycle
   override  init(style: UITableViewCell.CellStyle, reuseIdentifier : String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        backgroundColor = .clear
    
    getMusicVideos()
        collectionView.delegate = self
      //  collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(
            x: 20,
            y: 10,
            width: bounds.width,
            height: 40
        )
        collectionView.frame = CGRect(x: 0, y: titleLabel.frame.height + 10, width: bounds.width, height: bounds.height - 60)    }
    
    
    
    //MARK:- Get All Albums
    func getMusicVideos()  {
        videosViewModel.getVideos { [weak self ](isSuccess) in
            if isSuccess{
                guard self == self else {return }
                self?.bindCollectionView(videos: self!.videosViewModel.VideoBehaviorSubject)

            }
            
            

        }
    }
    
    //MARK:- Binding CollectionView
        func bindCollectionView(videos:  BehaviorSubject<[ResponseResult]>){
            videos.bind(to: collectionView.rx.items(cellIdentifier: VideoCollectionViewCell.identifier,cellType: VideoCollectionViewCell.self)) { row, item, cell in
                
                cell.configureCell(model: item)
                
            }.disposed(by: disposeBag)
            
            collectionView.rx.modelSelected(ResponseResult.self).subscribe(onNext: { [weak self] (model) in
                guard let url = URL(string: model.url) else {
                    print("cant get the url")
                    
                    return}
                print(" get the url")
                self?.delegate?.didSelectVideo(url: url)
                
                    }).disposed(by: disposeBag)
        }
    
}



//MARK:- Extension for CollectioView Delegate 
extension CollectionViewTableViewCell :UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    
    
}


