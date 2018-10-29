//
//  VitelityAPIClient.swift
//  VitelityApiFramework
//
//  Created by Jorge Enrique Dominguez on 10/29/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation
import BothamNetworking


public class VitelityApiClient {
    
    static var login: String = ""
    static var password: String = ""
    private static let bothamAPIClient = BothamAPIClient( baseEndpoint: VitelityAPIClientConfig.host)
    
    
    public static let didInventory : DIDsApiClient = DIDsApiClient(
        apiClient: bothamAPIClient,
        parser: DIDsParser())
    
    
    public init(){
        
    }
    
    public static func configureCredentials(login: String, password: String) {
        VitelityApiClient.login = login
        VitelityApiClient.password = password
        //initDefaultHeaders()
        initAuthentication()
    }
    
    
    private static func initAuthentication() {
        BothamAPIClient.globalRequestInterceptors.append(
            VitelityApiAuthentication(timeProvider: TimeProvider()))
    }
    
}
