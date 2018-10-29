//
//  TimeProvider.swift
//  VitelityApiFramework
//
//  Created by Jorge Enrique Dominguez on 10/29/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation

class TimeProvider {
    
    func currentTimeMillis() -> Int {
        return Int(NSDate().timeIntervalSince1970 * 1000)
    }
}
