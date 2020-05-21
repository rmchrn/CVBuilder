//
//  ServiceHandler.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 21/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import UIKit

enum httpMethod:String {
    case GET
    case POST
    case FORM
    case PUT
    case PATCH
    case DELETE
}

class ServiceHandler: NSObject, URLSessionDelegate {
    
    func getProfile(url: URL, completion: @escaping (PersonalInfo?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        urlRequest.httpMethod = httpMethod.GET.rawValue
        
        // set up the session
        let config = URLSessionConfiguration.ephemeral
        config.timeoutIntervalForRequest = 60
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print(error ?? "Error in request")
                completion(nil,error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                completion(nil,error)
                return
            }
            do {
                let peronalInfoModel = try JSONDecoder().decode(PersonalInfo.self, from: responseData)
                print(peronalInfoModel)
                completion(peronalInfoModel, nil)
            } catch {
                completion(nil,error)
            }
            
        }
        task.resume()
    }
}

extension ServiceHandler {
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        //Handle SSL Pinning for authentication challange.
    }
        
}
