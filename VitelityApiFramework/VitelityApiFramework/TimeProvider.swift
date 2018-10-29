//
//  TimeProvider.swift
//  VitelityClient
//
//  Created by Jorge Enrique Dominguez on 10/9/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//
import Foundation

class TimeProvider {
    
    func currentTimeMillis() -> Int {
        return Int(NSDate().timeIntervalSince1970 * 1000)
    }
}
