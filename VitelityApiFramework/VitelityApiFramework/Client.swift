//
//  Client.swift
//  VitelityApiFramework
//
//  Created by Jorge Enrique Dominguez on 10/29/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation

public class Clien{
    
    static var login: String = "Jorge"
    static var password: String = "Password"
    
    public init(){
        print("\(Clien.login) \(Clien.password)")
    }
    
    public func uuid() -> String {
        return UUID().uuidString
    }
    
    public func testName(){
        print("My name is jorge")
    }
    
    public static func configureCredentials(login: String, password: String) {
        Clien.login = login
        Clien.password = password
        //initDefaultHeaders()
        //initAuthentication()
    }
    
}
