//
//  ApiClient.swift
//  VitelityApiFramework
//
//  Created by Jorge Enrique Dominguez on 10/29/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation

public class ApiClient {
    
    static var login: String = ""
    static var password: String = ""
    
    
    public init(){
        
    }
    
    public static func configureCredentials(login: String, password: String) {
        ApiClient.login = login
        ApiClient.password = password
        //initDefaultHeaders()
        //initAuthentication()
    }
}
