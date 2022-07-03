//
//  BaseAPI.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import Foundation
import Alamofire

class BaseAPI <T: TargetType> {
    
    func fetchData<M: Codable> (target : T, responseClass : M.Type, completion: @escaping (Result<M?, NSError>)->Void){
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildPrams(task: target.task)
        let url = target.baseUrl + target.path
        AF.request(url, method: method, parameters: params.0, encoding: params.1, headers: headers).responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode else {
                // add custom Error
                completion(.failure(NSError()))
                return
            }
            if statusCode == 200 {
                // successful request
                guard let jsonResponse = try? response.result.get() else {
                    // add custom Error
                    completion(.failure(NSError()))
                    return
                }
                guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else  {
                    // add custom Error
                    completion(.failure(NSError()))
                    return
                }
                guard let jsonObject = try? JSONDecoder().decode(M.self, from: jsonData) else {
                    // add custom Error
                    completion(.failure(NSError()))
                    return
                }
                
                completion(.success(jsonObject))
                
                
                 
            }else {
                // add custom Error
                completion(.failure(NSError()))
            }
        }

    }

    private func buildPrams(task : Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        
        case .requestPlain:
            return  ([:], URLEncoding.default)
        case .requestParameter(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding )
        }
        
    }
    
}
