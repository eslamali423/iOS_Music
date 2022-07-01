//
//  VideoViewModel.swift
//  Podcast
//
//  Created by Eslam Ali  on 01/07/2022.
//

import Foundation
import RxCocoa
import RxSwift

class VideoViewModel{
    
    
    //MARK:- Vars
    var VideoBehaviorSubject = BehaviorSubject(value: [ResponseResult]())
    
    
    //MARK:- Methods
    func getVideos(completion : @escaping (Bool)->Void) {
        VideoAPI.shared.getData { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.VideoBehaviorSubject.on(.next(response?.feed.results ?? []))
               
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
