//
//  DidOrderingClient.swift
//  VitelityClient
//
//  Created by Jorge Enrique Dominguez on 10/20/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation
import BothamNetworking
import Result


public enum DIDOrderingType {
    case perminute
    case unlimited
    case pri(name:String)
}



public class DidOrdeingClient {
    
    
    private let apiClient: BothamAPIClient
    private let parser: DIDsParser
    
    
    init(apiClient: BothamAPIClient, parser: DIDsParser) {
        self.apiClient = apiClient
        self.parser = parser
    }
    
    
    //Orders a specific toll free number in our available list
    //routesip    The sub account or IP address to route this DID to
    
    public func getTollFree(number : Int, routesip : String, completion: @escaping (Result<Bool, BothamAPIClientError>) -> Void) {
        let params = ["cmd" : "gettollfree", "did" : "\(number)", "routesip": routesip ]
        
        apiClient.GET("", parameters: params) { response in
            completion(
                response.mapXML {
                    return self.parser.successFromXml(xml: $0)
                }
            )
        }
    }
   
    
    //Example of request with a pri name.
    //DIDOrderingType.pri(name: "MyPriName")
    
    public func getLocalDid(number : Int, routesip : String, type : DIDOrderingType,
                            completion: @escaping (Result<Bool, BothamAPIClientError>) -> Void) {
        
        var params = ["cmd" : "getlocaldid", "did" : "\(number)", "routesip": routesip ]
        switch type {
            case .perminute:
                params["type"] = "perminute"
            break
            case .unlimited:
                params["type"] = "unlimited"
            break
            case .pri(let name) :
                params["type"] = name
            break
        }
        
        apiClient.GET("", parameters: params) { response in
            completion(
                response.mapXML {
                    return self.parser.successFromXml(xml: $0)
                }
            )
        }
    }
    
    
    //Remove a currently assigned DID number
    public func removeDid(number : Int, completion: @escaping (Result<Bool, BothamAPIClientError>) -> Void) {
        
        let params = ["cmd" : "removedid", "did" : "\(number)"]
        
        apiClient.GET("", parameters: params) { response in
            completion(
                response.mapXML {
                    return self.parser.successFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    
    //orders a specific toll free number from the SMS800 available pool
    public func requestVanity(number : Int, completion: @escaping (Result<Bool, BothamAPIClientError>) -> Void) {
        
        let params = ["cmd" : "requestvanity", "did" : "\(number)"]
        
        apiClient.GET("", parameters: params) { response in
            completion(
                response.mapXML {
                    return self.parser.successFromXml(xml: $0)
                }
            )
        }
    }

    
    //Create this function later i dont understand it.
    public func localBackOrder(){
        
    }
    
    
    //Create this function later i dont understand it.
    public func localbackorderrate(){
        
    }
    
    
    //Force the billing for a specific DID to a certain sub account
    //subacc    The sub account or IP address to bill to or NONE    Yes    subaccount or none
    public func didForceBilling(number : Int, subacc : String,  completion: @escaping (Result<Bool, BothamAPIClientError>) -> Void){
        
        let params = ["cmd" : "didforcebilling", "did" : "\(number)", "subacc" : subacc  ]
        
        apiClient.GET("", parameters: params) { response in
            completion(
                response.mapXML {
                    return self.parser.successFromXml(xml: $0)
                }
            )
        }
        
    }
    
    
    //Reserve a DID for a period of time without ordering it
    public func reserveDid(number : Int, reservedHours : Int = 24,  completion: @escaping (Result<Bool, BothamAPIClientError>) -> Void){
        let params = ["cmd" : "reservedid", "did" : "\(number)", "time" : "\(reservedHours)hr"]
        
        apiClient.GET("", parameters: params) { response in
            completion(
                response.mapXML {
                    return self.parser.successFromXml(xml: $0)
                }
            )
        }
    }
    
    
    //Release a DID that you were holding temporarily with reserve
    public func releaseDid(number : Int,  completion: @escaping (Result<Bool, BothamAPIClientError>) -> Void){
        let params = ["cmd" : "releasedid", "did" : "\(number)"]
        
        apiClient.GET("", parameters: params) { response in
            completion(
                response.mapXML {
                    return self.parser.successFromXml(xml: $0)
                }
            )
        }
    }
    
    
    //returns the gotten international did number for the requested are. ex. 4420234832423 or empty if fails.
    public func getInternationalDid(ratecenter : String, country : String, completion: @escaping (Result<String?, BothamAPIClientError>) -> Void){
        
        let params = ["cmd" : "getintldid", "ratecenter" : ratecenter, "country" : country]
        apiClient.GET("", parameters: params) { response in
            completion(
                response.mapXML {
                    return self.parser.intNumberFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    // Leaving this for later when i need to use it.
    /*public func getDidsRateCenter(byState state : String, completion: @escaping (Result<GetLocalDIDs, BothamAPIClientError>) -> Void){
        
        
    }*/



}
