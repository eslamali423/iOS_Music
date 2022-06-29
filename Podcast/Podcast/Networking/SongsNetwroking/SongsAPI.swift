//
//  SongsAPI.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import Foundation
class SongsAPI  : BaseAPI <SongsNetwroking> {
    
    static let shared  =  SongsAPI()
    
    func getData(completion: @escaping (Result<APIResponse?, NSError>)->Void) {
        self.fetchData(target: .getSongs , responseClass: APIResponse.self) { (result) in
            completion(result)
        }
    }
    
    
}
