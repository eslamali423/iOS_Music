//
//  SongsViewModel.swift
//  Podcast
//
//  Created by Eslam Ali  on 01/07/2022.
//

import Foundation
import RxCocoa
import RxSwift

class SongsViewModel{
    
    
    //MARK:- Vars
    var songsBehaviorSubject = BehaviorSubject(value: [ResponseResult]())
    
    
    //MARK:- Methods
    func getSongs(completion : @escaping (Bool)->Void) {
        SongsAPI.shared.getData { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.songsBehaviorSubject.on(.next(response?.feed.results ?? []))
               
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
