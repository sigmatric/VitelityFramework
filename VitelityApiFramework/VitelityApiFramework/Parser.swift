//
//  Parser.swift
//  VitelityClient
//
//  Created by Jorge Enrique Dominguez on 10/10/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation
import SwiftyXMLParser

protocol Parser {
    associatedtype T
    
    func fromXML(xml: XML.Accessor) -> T
    
}
