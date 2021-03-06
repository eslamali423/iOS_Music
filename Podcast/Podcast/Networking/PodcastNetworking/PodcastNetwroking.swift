//
//  PodcastNetwroking.swift
//  Podcast
//
//  Created by Eslam Ali  on 02/07/2022.
//

import Foundation
import Alamofire

enum PodcastNetworking {
    case getPodcasts
}

extension PodcastNetworking : TargetType {
    
    var baseUrl: String {
        
        get {return "https://rss.applemarketingtools.com/api/v2/eg/music/most-played/50/songs.json"}
        set {}
    }
        
        
        var path: String {
        switch self {
        case .getPodcasts:
            return ""
        
    
        }
        }
        
        var method: HTTPMethod {
        switch self  {
        case .getPodcasts :
        return .get
        
      
        }
        }
        
        var task: Task {
        switch self {
        case .getPodcasts:
        return .requestPlain
    
        }
        }
        
        var headers: [String : String]? {
        return [:]
        }
        
        
    }










