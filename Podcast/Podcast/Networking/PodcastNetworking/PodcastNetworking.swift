//
//  PodcastNetworking.swift
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
        
        get {return "https://rss.applemarketingtools.com/api/v2/eg/podcasts/top/50"}
        set {}
    }
        
        var path: String {
        switch self {
        case .getPodcasts:
            return "/podcasts.json"
        
    
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
