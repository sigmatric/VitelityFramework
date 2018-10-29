//
//  LnpParser.swift
//  VitelityClient
//
//  Created by Jorge Enrique Dominguez on 10/20/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation
import SwiftyXMLParser
import BothamNetworking
import Result


class LnpParser: Parser {
    
    typealias T = AddPortResponseDTO?
    
    func fromXML(xml: XML.Accessor) -> AddPortResponseDTO? {
          return parseAddPortResponse(xml: xml)
    }
   
    
    private func parseAddPortResponse(xml : XML.Accessor) -> T {
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                if let response = xml["content", "response"].text {
                    if response == "ok" || response == "success" {
                        
                        let portId =  xml["content", "portid"].text ?? ""
                        let signatureRequired =  ((xml["content", "sig_required"].text ?? "") == "yes" ? true : false)
                        let billRequired =  ((xml["content", "bill_required"].text ?? "") == "yes" ? true : false)
                        
                        return AddPortResponseDTO(portid: portId, signatureRequired: signatureRequired, billRequired: billRequired)
                    }
                }
            }
        }
        
        return nil
    }
    
    
    

}
