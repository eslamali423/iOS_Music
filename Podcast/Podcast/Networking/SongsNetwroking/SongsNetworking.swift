//
//  SongsNetworking.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import Foundation
import Alamofire

enum SongsNetwroking {
    case getSongs
  
    
}

extension SongsNetwroking : TargetType {
    
    var baseUrl: String {
        
        get {return "https://rss.applemarketingtools.com/api/v2/eg/music/most-played/50/"}
        set {}
    }
        
        
        var path: String {
        switch self {
        case .getSongs:
            return "songs.json"
        
    
        }
        }
        
        var method: HTTPMethod {
        switch self  {
        case .getSongs :
        return .get
        
      
        }
        }
        
        var task: Task {
        switch self {
        case .getSongs:
        return .requestPlain
    
        }
        }
        
        var headers: [String : String]? {
        return [:]
        }
        
        
    }
