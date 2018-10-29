//
//  LocalDIDsClient.swift
//  VitelityClient
//
//  Created by Jorge Enrique Dominguez on 10/10/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation
import BothamNetworking
import Result


public enum DIDType : String {
    case perminute
    case unlimited
    case pri
}



public class DIDsApiClient {
    
    
    private let apiClient: BothamAPIClient
    private let parser: DIDsParser
    
    
    init(apiClient: BothamAPIClient, parser: DIDsParser) {
        self.apiClient = apiClient
        self.parser = parser
    }
    
    
    
    
    public func getLocalDids(state : String, withRates : Bool = true, type: DIDType?, rateCenter : String?, smsOnly : Bool?, cnamCampable : Bool?, completion: @escaping (Result<GetLocalDIDs, BothamAPIClientError>) -> Void) {
        assert(!state.isEmpty)
        var params = ["cmd" : "listlocal", "state": state, "withrates" : withRates ? "yes" : "no" ]
       
        if(smsOnly != nil){ params["smsonly"] = (smsOnly! ? "yes" : "no") }
        if(cnamCampable != nil){ params["cnam"] = (smsOnly! ? "yes" : "no") }
        if(type != nil){ params["type"] = type?.rawValue }
        if(rateCenter != nil){ params["ratecenter"] = rateCenter }
        
        apiClient.GET("", parameters: params) { response in
            completion(
                response.mapXML {
                    return self.parser.fromXML(xml: $0)
                }
            )
        }
    }
    
    
    
    
    
    public func getTollFrees(limit : Int?, completion: @escaping (Result<GetTollFrees, BothamAPIClientError>) -> Void) {
        
        var params : [String: String] = [:]
        if limit != nil {
            let limitS : Int = limit!
            params = ["cmd" : "listtollfree", "limit" : "\(limitS)"]
        } else {
            params = ["cmd" : "listtollfree"]
        }
        
        apiClient.GET("", parameters: params) { response in
            completion(
                response.mapXML {
                    return self.parser.tollFreesFromXml(xml: $0)
                }
            )
        }
    }
    
    
    //Parser should work.
    public func getNpaNxx(npanxx: Int, type : DIDType, withRates : Bool = true,  completion: @escaping (Result<GetLocalDIDs, BothamAPIClientError>) -> Void) {
        assert(npanxx <= 999999 )
        let params = ["cmd" : "listnpanxx", "npanxx" : String(npanxx), "type" : type.rawValue, "withrates" : (withRates ? "yes" : "no") ]
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.fromXML(xml: $0)
                }
            )
        }
    }
    
    
    
    
    public func getNpa(npa: Int, type : DIDType, withRates : Bool = true,  completion: @escaping (Result<GetLocalDIDs, BothamAPIClientError>) -> Void) {
        assert(npa <= 999 )
        let params = ["cmd" : "listnpa", "npa" : String(npa), "type" : type.rawValue, "withrates" : (withRates ? "yes" : "no") ]
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.fromXML(xml: $0)
                }
            )
        }
    }
    
    
    
    
    public func getRateCenters(byState state : String, type : DIDType?, completion: @escaping (Result<GetRateCenters, BothamAPIClientError>) -> Void ) {
        assert(!state.isEmpty)
        var params : [String: String] = [:]
        if type != nil {
            params = ["cmd" : "listratecenters"]
        } else {
            params = ["cmd" : "listratecenters", "type" : type?.rawValue ?? ""]
        }
       
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.rateCentersFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    public func getAvailableRateCenters(byState state : String, type : DIDType?, smsOnly : Bool?, completion: @escaping (Result<GetRateCenters, BothamAPIClientError>) -> Void ) {
        assert(!state.isEmpty)
        
        var params : [String: String] = ["cmd" : "listavailratecenters"]
        if(type != nil){ params["type"] = type?.rawValue }
        if(smsOnly != nil){ params["smsonly"] = (smsOnly! ? "yes" : "no") }
        
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.rateCentersFromXml(xml: $0)
                }
            )
        }
        
    }
    
    
    
    public func searchTollFree(withPattern pattern : String, completion: @escaping (Result<GetTollFrees, BothamAPIClientError>) -> Void ) {
        assert(!pattern.isEmpty)
        let params  = ["cmd" : "searchtoll", "did" : pattern]
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.tollFreesFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    
    public func getAvailableStates(type : DIDType?, smsOnly : Bool?, completion: @escaping (Result<GetStates, BothamAPIClientError>) -> Void){
        
        var params : [String: String] = ["cmd" : "listavailstates"]
        if(type != nil){ params["type"] = type?.rawValue }
        if(smsOnly != nil){ params["smsonly"] = (smsOnly! ? "yes" : "no") }
        
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.statesFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    
    public func getAllStates(type : DIDType?,  completion: @escaping (Result<GetStates, BothamAPIClientError>) -> Void) {
        
        var params : [String: String] = ["cmd" : "liststates"]
        if(type != nil){ params["type"] = type?.rawValue }
        
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.statesFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    
    public func getAccountDids(displayExtraInfo : Bool = true, completion: @escaping (Result<GetAccountDids, BothamAPIClientError>) -> Void){
        let params : [String: String] = ["cmd" : "listdids", "extra" : "yes"]
        
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.accountDidsFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    
    public func getInternationalRateCenters(countryCode : String, completion: @escaping (Result<GetRateCenters, BothamAPIClientError>) -> Void){
        assert(!countryCode.isEmpty)
        let params : [String: String] = ["cmd" : "listintlratecenters", "country" : countryCode]
        
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.rateCentersFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    func addNoteToDid(accountDid did : String, note: String, completion: @escaping (Result<Bool, BothamAPIClientError>) -> Void) -> Void {
        assert(!did.isEmpty && !note.isEmpty)
        let params : [String: String] = ["cmd" : "didnote", "did" : did, "note" : note]
        
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.successFromXml(xml: $0)
                }
            )
        }
    }
    
    
    // Lists all countries supported for International DIDs
    func getAvailableCountries(completion: @escaping (Result<GetCountries, BothamAPIClientError>) -> Void) -> Void {
        
        let params : [String: String] = ["cmd" : "listintl"]
        
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.countriesFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    func getDidNote(accountDid did : String, completion: @escaping (Result<GetLocalDIDs, BothamAPIClientError>) -> Void) -> Void {
        assert(!did.isEmpty)
        let params : [String: String] = ["cmd" : "listintl", "did" : did]
        
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.fromXML(xml: $0)
                }
            )
        }
    }
    
    
    
    
    func getDidRates(forDid did : String, onAccount : Bool?, showSate : Bool?, withRates : Bool = true, completion: @escaping (Result<DidRateDTO?, BothamAPIClientError>) -> Void) -> Void {
        assert(!did.isEmpty)
        var params : [String: String] = ["cmd" : "listspecificlocal", "did" : did, "withrates" : withRates ? "yes":"no"]
        if(showSate != nil){ params["addstate"] = (showSate! ? "yes" : "no") }
        if(onAccount != nil){ params["onaccount"] = (onAccount! ? "yes" : "no") }
        
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.didRateFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    
    func setCallerIdName(forDid did : String, name : String, completion: @escaping (Result<Bool, BothamAPIClientError>) -> Void )-> Void{
        assert(!did.isEmpty && !name.isEmpty)
        let params : [String: String] = ["cmd" : "lidb", "did" : did, "name" : name]
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.successFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    
    func getCnamCapableDids( completion: @escaping (Result<GetCnamDids, BothamAPIClientError>) -> Void ) -> Void {
        let params = ["cmd" : "lidbavailall"]
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.cnamDidsFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    
    func getAccountDidRate( did : String, completion: @escaping (Result<DidRateDTO?, BothamAPIClientError>) -> Void ) -> Void {
        let params = ["cmd" : "getdidrate"]
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.didRateFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    
    func getDidsWithVoicemail(voicemail : Int, completion: @escaping (Result<GetVMDids, BothamAPIClientError>) -> Void) {
        let params = ["cmd" : "listvmdids", "vmbox" : "\(voicemail)"]
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.vmDidsFromXml(xml: $0)
                }
            )
        }
    }
    
    
    
    func setEmailForVoicemail(voicemail : Int, email : String, completion: @escaping (Result<Bool, BothamAPIClientError>) -> Void) -> Void {
        
        //Check is is a valid email
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let validEmail : Bool =  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        
        if validEmail == true {
            let params = ["cmd" : "setvmemail", "vmbox" : "\(voicemail)", "email" : email]
            apiClient.GET("", parameters: params ) { response in
                completion(
                    response.mapXML {
                        return self.parser.successFromXml(xml: $0)
                    }
                )
            }
        } else {
            let ApiError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Ivalid email \(email)"])
            completion( Result.failure(BothamAPIClientError.parsingError(error: ApiError)))
        }
    }
    
    
    
    
    func getDidsNotes(completion: @escaping (Result<GetDidsNotes, BothamAPIClientError>) -> Void) -> Void {
        let params = ["cmd" : "getdidnotes"]
        apiClient.GET("", parameters: params ) { response in
            completion(
                response.mapXML {
                    return self.parser.didsNotesFromXml(xml: $0)
                }
            )
        }
    }
    
  
    
}
