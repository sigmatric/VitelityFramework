//
//  DIDsParser.swift
//  VitelityClient
//
//  Created by Jorge Enrique Dominguez on 10/10/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//


import Foundation
import SwiftyXMLParser
import BothamNetworking
import Result


class DIDsParser: Parser {
    
    typealias T = GetLocalDIDs
    typealias RC = GetRateCenters
    typealias ST = GetStates
    typealias ADID = GetAccountDids
    typealias CT = GetCountries
    typealias CNAMDID = GetCnamDids
    typealias VMDID = GetVMDids
    typealias DIDNOTE = GetDidsNotes
    
    
    
    func fromXML(xml: XML.Accessor) -> T {
        return parseGetLocalDids(xml: xml)
    }
    
    
    func tollFreesFromXml(xml: XML.Accessor) -> GetTollFrees {
        return parseGetTollFrees(xml: xml)
    }
    
    
    func rateCentersFromXml(xml: XML.Accessor) -> RC {
        return parseGetRateCenters(xml : xml)
    }
    
    
    func statesFromXml(xml: XML.Accessor) -> ST {
        return parseGetStates(xml : xml)
    }
    
    
    func accountDidsFromXml(xml: XML.Accessor) -> ADID {
        return parseGetAccountDids(xml : xml)
    }
    
    
    func successFromXml(xml: XML.Accessor) -> Bool {
        return parseSuccess(xml:xml)
    }
    
    
    func countriesFromXml(xml: XML.Accessor) -> CT {
        return parseGetCountries(xml : xml)
    }
    
    
    func didRateFromXml(xml: XML.Accessor) -> DidRateDTO? {
        return parseDidRate(xml : xml)
    }
    
    
    func cnamDidsFromXml(xml: XML.Accessor) -> CNAMDID {
        return parseGetCnamDids(xml : xml)
    }
    
    func vmDidsFromXml(xml: XML.Accessor) -> VMDID {
        return parseGetVmDids(xml : xml)
    }
    
    func didsNotesFromXml(xml: XML.Accessor) -> DIDNOTE {
        return parseGetDidNotes(xml : xml)
    }
    
    
    func intNumberFromXml(xml: XML.Accessor) -> String? {
        return parseIntNumberFromXml(xml: xml)
    }
    
    
    private func parseGetAccountDids(xml: XML.Accessor) -> ADID {
        return ADID(dids: parseAccountDids(xml: xml))
    }
    
    
    private func parseGetLocalDids(xml: XML.Accessor) -> T {
        return GetLocalDIDs(dids: parseDids(xml: xml))
    }
    
    
    private func parseGetTollFrees(xml: XML.Accessor) -> GetTollFrees  {
        return GetTollFrees(tollfrees : parseTollFrees(xml: xml))
    }
    
    private func parseGetRateCenters(xml: XML.Accessor) -> RC  {
        return RC(rateCenters : parseRateCenters(xml: xml))
    }
    
    
    private func parseGetStates(xml: XML.Accessor) -> ST  {
        return ST(states : parseStates(xml: xml))
    }
    
    
    private func parseGetCountries(xml: XML.Accessor) -> CT  {
        return CT(countries : parseCountries(xml: xml))
    }
    
    
    private func parseGetCnamDids(xml: XML.Accessor) -> CNAMDID {
        return CNAMDID(numbers: parseCnamDids(xml: xml))
    }
    
    private func parseGetVmDids(xml: XML.Accessor) -> VMDID {
        return VMDID(numbers: parseVmDids(xml: xml))
    }
    
    
    private func parseGetDidNotes(xml: XML.Accessor) -> DIDNOTE {
        return DIDNOTE(numbers: parseDidNotes(xml: xml))
    }
    
    
    
    
    private func parseDidRate(xml : XML.Accessor) -> DidRateDTO? {
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                if let number = xml["content", "response", "number"].text {
                    let perMinuteRate =  xml["content", "response", "per_minute_rate"].double ?? 0
                    let monthlyRate =  xml["content", "response", "mrc"].double ?? 0
                    let numberRate = DidRateDTO(number: number, perMinuteRate: perMinuteRate, monthlyRate: monthlyRate)
                    return numberRate
                }
            }
        }
        
        return nil
    }
    
    
    
    private func parseSuccess(xml : XML.Accessor) -> Bool {
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                if let response = xml["content", "response"].text {
                    if response == "ok" || response == "success" {
                         return true
                    }
                }
            }
        }
       
        return false
    }
    
    
    private func parseIntNumberFromXml(xml : XML.Accessor) -> String? {
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                if let response = xml["content", "response"].text {
                    if response == "ok" || response == "success" {
                        if let did = xml["content", "did"].text {
                            return did
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    
    
    
    private func parseCountries(xml : XML.Accessor) -> [CountryDTO] {
        var countryArr : [CountryDTO] = []
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                for st in xml["content", "states", "state"] {
                    if let country = st["country"].text {
                        if !country.isEmpty {
                            let shortTerm = st["st"].text ?? ""
                            let countryDTO : CountryDTO = CountryDTO(shortTerm: shortTerm, name: country)
                            countryArr.append(countryDTO)
                        }
                    }
                }
                
            } else {
                if let error = xml["content"]["error"].text {
                    print("Error: \(error)")
                    
                    return countryArr // Return empty array.
                    //Log Error to a Database.
                }
            }
        }
        
        return countryArr
    }
    
    
    
    private func parseStates(xml : XML.Accessor) -> [StateDTO] {
        var statesArr : [StateDTO] = []
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                for st in xml["content", "states", "state"] {
                    if let name = st.text {
                        if !name.isEmpty {
                            let rateCenter : StateDTO = StateDTO(name: name)
                            statesArr.append(rateCenter)
                        }
                    }
                }
                
            } else {
                if let error = xml["content"]["error"].text {
                    print("Error: \(error)")
                    
                    return statesArr // Return empty array.
                    //Log Error to a Database.
                }
            }
        }
        
        return statesArr
    }
    
    
    
    
    private func parseRateCenters(xml : XML.Accessor) -> [RateCenterDTO] {
        var rateCentersArr : [RateCenterDTO] = []
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                for rc in xml["content", "ratecenters", "rc"] {
                    let rateCenter : RateCenterDTO = RateCenterDTO(name: rc.text ?? "")
                    rateCentersArr.append(rateCenter)
                }
                
            } else {
                if let error = xml["content"]["error"].text {
                    print("Error: \(error)")
                    
                    return rateCentersArr // Return empty array.
                    //Log Error to a Database.
                }
            }
        }
        
        return rateCentersArr
    }
    
    
    
    private func parseTollFrees(xml : XML.Accessor) -> [TollFreeDTO] {
        var tollFreeArr : [TollFreeDTO] = []
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                for did in xml["content", "numbers", "did"] {
                    let number = did["number"].text ?? ""
                    let tollFree : TollFreeDTO = TollFreeDTO(number: number)
                    tollFreeArr.append(tollFree)
                }
                
            } else {
                if let error = xml["content"]["error"].text {
                    print("Error: \(error)")
                    
                    return tollFreeArr // Return empty array.
                    //Log Error to a Database.
                }
            }
        }
            
        return tollFreeArr
    }
    
    
    
    private func parseVmDids(xml : XML.Accessor) -> [VMDidDTO] {
        var vmDids : [VMDidDTO] = []
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                for number in xml["content", "numbers", "number"] {
                    let vmNumber : VMDidDTO = VMDidDTO(number: number.text ?? "")
                    vmDids.append(vmNumber)
                }
                
                return vmDids
                
            } else {
                if let error = xml["content"]["error"].text {
                    print("Error: \(error)")
                    
                    return vmDids // Return empty array.
                    //Log Error to a Database.
                }
            }
        }
        
        return vmDids
    }
    
    
    
    private func parseAccountDids(xml : XML.Accessor ) -> [AccountDidDTO] {
        
        var AccountDidArr : [AccountDidDTO] = []
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                for number in xml["content", "numbers", "number"] {
                    
                    let did = number["did"].text ?? ""
                    let ratecenter = number["ratecenter"].text ?? ""
                    let state = number["state"].text ?? ""
                    let costPerMinute : Double = number["cost_per_minute"].double ?? 0
                    let costPerMonth : Double = number["cost_per_month"].double ?? 0
                    let subAccount : String = number["subaccount"].text ?? ""
                    
                    let accountDID : AccountDidDTO = AccountDidDTO(number: did, ratecenter: ratecenter, state: state, costPerMinute: costPerMinute, costPerMonth: costPerMonth, subAccount: subAccount)
                    AccountDidArr.append(accountDID)
                }
                
            } else {
                if let error = xml["content"]["error"].text {
                    print("Error: \(error)")
                    return AccountDidArr
                }
            }
        }
        
        return AccountDidArr
    }
    
    
    private func parseDids(xml : XML.Accessor ) -> [DidDTO] {
        
        var didArr : [DidDTO] = []
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                for did in xml["content", "numbers", "did"] {
                    
                    let number = did["number"].text ?? ""
                    let ratecenter = did["ratecenter"].text ?? ""
                    let state = did["state"].text ?? ""
                    let costPerMinute : Double? = did["cost_per_minute"].double ?? nil
                    let costPerMonth : Double? = did["cost_per_month"].double ?? nil
                    let setUpFee : Double? = did["setupfee"].double ?? nil
                    
                    let didDto : DidDTO = DidDTO(number: number, ratecenter: ratecenter, state: state, costPerMinute: costPerMinute, costPerMonth: costPerMonth, setupFee: setUpFee)
                    didArr.append(didDto)
                }
                
            } else {
                if let error = xml["content"]["error"].text {
                    print("Error: \(error)")
                    return didArr
                }
            }
        }
        
        return didArr
    }
    
    
    
    private func parseCnamDids(xml : XML.Accessor ) -> [CnamDidDTO] {
        
        var didArr : [CnamDidDTO] = []
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                for number in xml["content", "numbers", "number"] {
                    let cnamDidDto : CnamDidDTO = CnamDidDTO(number: number.text ?? "")
                    didArr.append(cnamDidDto)
                }
                
            } else {
                if let error = xml["content"]["error"].text {
                    print("Error: \(error)")
                    return didArr
                }
            }
        }
        
        return didArr
    }
    
    
    
    private func parseDidNotes(xml : XML.Accessor ) -> [DidNoteDTO] {
        
        var didArr : [DidNoteDTO] = []
        
        if let status = xml["content", "status"].text {
            if status == "ok" {
                for number in xml["content", "numbers", "number"] {
                    let cnamDidDto : DidNoteDTO = DidNoteDTO(number: number["did"].text ?? "", note: number["note"].text ?? "")
                    didArr.append(cnamDidDto)
                }
                
            } else {
                if let error = xml["content"]["error"].text {
                    print("Error: \(error)")
                    return didArr
                }
            }
        }
        
        return didArr
    }
    
}
