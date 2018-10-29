//
//  DefaultHeadersRequestInterceptor.swift
//  VitelityClient
//
//  Created by Jorge Enrique Dominguez on 10/9/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation
import BothamNetworking

/*class DefaultHeadersRequestInterceptor: BothamRequestInterceptor {
    
    func intercept(_ request: HTTPRequest) -> HTTPRequest {
        /*let defaultHeaders = VitelityAPIClientConfig.defaultHeaders.filter {
            return request.headers?[$0.0] == nil
        }*/
        return request.appendingHeaders(VitelityAPIClientConfig.defaultHeaders)
    }
}*/
