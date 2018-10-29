//
//  Dictionary.swift
//  VitelityClient
//
//  Created by Jorge Enrique Dominguez on 10/9/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation

extension Dictionary {
    init(_ pairs: [Element]) {
        self.init()
        for (k, v) in pairs {
            self[k] = v
        }
    }
}
