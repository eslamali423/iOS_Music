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
 

    func getAlbums(completion : @escaping (Bool)->Void) {
        AlbumsAPI.shared.getData { (result) in
            switch result {
            case .success(let response):
                print(response?.feed.title)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    
    
}
