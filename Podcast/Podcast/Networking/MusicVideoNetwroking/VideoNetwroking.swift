//
//  VideoNetwroking.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import Foundation
import Alamofire

enum VideoNetworking {
    case getVideos
  
    
}

extension VideoNetworking : TargetType {
    
    var baseUrl: String {
        
        get {return "https://rss.applemarketingtools.com/api/v2/eg/music/most-played/50/"}
        set {}
    }
        
        
        var path: String {
        switch self {
        case .getVideos:
            return "albums.json"
        
    
        }
        }
        
        var method: HTTPMethod {
        switch self  {
        case .getVideos :
        return .get
        
      
        }
        }
        
        var task: Task {
        switch self {
        case .getVideos:
        return .requestPlain
    
        }
        }
        
        var headers: [String : String]? {
        return [:]
        }
        
        
    }
