//
//  VitelityApiAuthentication.swift
//  VitelityClient
//
//  Created by Jorge Enrique Dominguez on 10/9/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation
import BothamNetworking

class VitelityAPIAuthentication: BothamRequestInterceptor {
    
    private let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func intercept(_ request: HTTPRequest) -> HTTPRequest {
        //let timestamp = timeProvider.currentTimeMillis()
        /*let privateKey = MarvelAPIClient.privateKey
        let publicKey = MarvelAPIClient.publicKey
        let hash = MarvelHashGenerator.generateHash(timestamp: Int(timestamp),
                                                    privateKey: privateKey,
                                                    publicKey: publicKey)
        let authParams = [MarvelAPIParams.timestamp: "\(timestamp)",
            MarvelAPIParams.apiKey: publicKey,
            MarvelAPIParams.hash: hash]*/
        
        
        let authParams = ["login" : VitelityAPIClient.login, "pass": VitelityAPIClient.password, "xml" : "yes"]
        return request.appendingParameters(authParams)
       
    }
    
}
