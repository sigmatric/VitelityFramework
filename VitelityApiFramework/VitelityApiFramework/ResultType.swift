//
//  ResultType.swift
//  VitelityClient
//
//  Created by Jorge Enrique Dominguez on 10/9/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation
import BothamNetworking
import SwiftyXMLParser
import Result


public extension ResultProtocol where Value == HTTPResponse, Error == BothamAPIClientError {
    
    public func mapXML<U>(_ transform: @escaping (XML.Accessor) -> U) -> Result<U, BothamAPIClientError> {
        return flatMap { _ in
            let data = String(data: (self.value?.body)!, encoding: String.Encoding.utf8) as String!
            return dataToXMLResult(data).map { transform($0) }
        }
    }
    
    
    private func dataToXMLResult(_ data: String?) -> Result<XML.Accessor, BothamAPIClientError> {
        do {
            let xml = try XML.parse(data!)  //try JSONSerialization.jsonObject(with: (data ?? NSData()) as Data, options: .allowFragments)
            if let status = xml["content"]["status"].text{
                if status == "failed" || status == "fail" || status == "invalid" {
                    var errorReturn : String = ""
                    if let error = xml["content"]["error"].text {
                        if !error.isEmpty {
                            errorReturn = error
                        }
                    } else {
                        if let error = xml["content"]["response"].text {
                            if !error.isEmpty {
                                errorReturn = error
                            }
                        }
                    }
                    
                    let ApiError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : errorReturn])
                    print("Error FOUND :::: \(errorReturn)")
                    return Result.failure(BothamAPIClientError.parsingError(error: ApiError))
                    
                } else {
                    return Result.success(xml)
                }
            }
            
            return Result.success(xml)
            
        } catch {
            let parsingError = error as NSError
            return Result.failure(BothamAPIClientError.parsingError(error: parsingError))
        }
    }
}



