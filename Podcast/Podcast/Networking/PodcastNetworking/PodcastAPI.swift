//
//  PodcastAPI.swift
//  Podcast
//
//  Created by Eslam Ali  on 02/07/2022.
//

import Foundation
class PodcastAPI  : BaseAPI <PodcastNetworking> {
    
    static let shared  =  PodcastAPI()
    
    func getData(completion: @escaping (Result<APIResponse?, NSError>)->Void) {
        self.fetchData(target: .getPodcasts , responseClass: APIResponse.self) { (result) in
            completion(result)
        }
    }
    
    
}
