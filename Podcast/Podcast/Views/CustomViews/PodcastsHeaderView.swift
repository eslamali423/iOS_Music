//
//  PodcastsHeaderView.swift
//  Podcast
//
//  Created by Eslam Ali  on 02/07/2022.
//

import RxSwift
import RxCocoa


protocol PodcastsDelegate : AnyObject {
    func didSelectPodcast(url : URL)
}

class PodcastsHeaderView: UICollectionReusableView{
    
    //MARK:- Vars
    var disposeBag =  DisposeBag()
    weak var delegate : PodcastsDelegate?
    
    private let titleLabel : UILabel = {
        let label =  UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Podcasts"
        label.font = .systemFont(ofSize: 28, weight: .black)
        return label
    }()
    
    private let collectionView : UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
          layout.itemSize = CGSize(width: 180, height: 200)
        
        let collectionView = UICollectionView(frame: .zero,  collectionViewLayout: layout)
        collectionView.register(PodcastCollectionViewCell.self, forCellWithReuseIdentifier: PodcastCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    //MARK:- Initlizaers
    init(frame: CGRect, podcasts:  BehaviorSubject<[ResponseResult]>) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.clipsToBounds = true
        
        addSubview(titleLabel)
        addSubview(collectionView)
        
        
        collectionView.delegate = self
        //        collectionView.dataSource = self
        
        
        bindCollectionView(podcasts: podcasts)
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
    func bindCollectionView(podcasts:  BehaviorSubject<[ResponseResult]>){
        podcasts.bind(to: collectionView.rx.items(cellIdentifier: PodcastCollectionViewCell.identifier,cellType: PodcastCollectionViewCell.self)) { row, item, cell in
            
            cell.configureCell(model: item)
            
        }.disposed(by: disposeBag)
        
//        collectionView.rx.modelSelected(ResponseResult.self).subscribe(onNext: { [weak self] (model) in
//            guard let url = URL(string: model.url) else {
//                print("cant get the url")
//
//                return}
//            print(" get the url")
//
//            self?.delegate?.didSelectPodcast(url: url)
//
//        }).disposed(by: disposeBag)
        
        
    }
}


//MARK:- Extension for CollectionView Functions
extension PodcastsHeaderView :  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 170, height: 200)
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        }
    
}




