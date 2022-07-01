//
//  AlbumsViewModel.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import Foundation
import RxCocoa
import RxSwift

class AlbumsViewModel {
    
    //MARK:- Vars
    var albumsBehaviorSubject = BehaviorSubject(value: [ResponseResult]())
    
    
    //MARK:- Methods
    func getAlbums(completion : @escaping (Bool)->Void) {
        AlbumsAPI.shared.getData { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.albumsBehaviorSubject.on(.next(response?.feed.results ?? []))
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    
    
}
