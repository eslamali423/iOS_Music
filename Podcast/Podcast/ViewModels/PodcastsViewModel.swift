//
//  PodcastsViewModel.swift
//  Podcast
//
//  Created by Eslam Ali  on 02/07/2022.
//

import Foundation
import RxCocoa
import RxSwift

class PodcastsViewModel {
    
    //MARK:- Vars
    var pdocastBehaviorSubject = BehaviorSubject(value: [ResponseResult]())
    
    
    //MARK:- Methods
    func getPodcasts(completion : @escaping (Bool)->Void) {
        AlbumsAPI.shared.getData { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.pdocastBehaviorSubject.on(.next(response?.feed.results ?? []))
                print(response?.feed.results[1].name)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    
    
}
