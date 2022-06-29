//
//  MusicAPI.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import Foundation
class AlbumsAPI  : BaseAPI <AlbumsNetwroking> {
    
    static let shared  =  AlbumsAPI()
    
    func getData(completion: @escaping (Result<APIResponse?, NSError>)->Void) {
        self.fetchData(target: .getAlbums, responseClass: APIResponse.self) { (result) in
            completion(result)
        }
    }
    
    
}
