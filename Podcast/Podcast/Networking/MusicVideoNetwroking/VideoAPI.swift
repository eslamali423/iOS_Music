//
//  VideoAPI.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import Foundation
class VideoAPI  : BaseAPI <VideoNetworking> {
    
    static let shared  =  VideoAPI()
    
    func getData(completion: @escaping (Result<APIResponse?, NSError>)->Void) {
        self.fetchData(target: .getVideos , responseClass: APIResponse.self) { (result) in
            completion(result)
        }
    }
    
    
}
