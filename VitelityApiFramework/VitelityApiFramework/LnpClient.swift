//
//  LnpClient.swift
//  VitelityClient
//
//  Created by Jorge Enrique Dominguez on 10/20/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//


import Foundation
import BothamNetworking
import Result


public enum RatePlanType : String {
    case ppm
    case unlim
    case vfax
}


public enum PortType : String {
    case residential
    case business
}



public class LnpClient {
    
    private let apiClient: BothamAPIClient
    private let parser: DIDsParser
    
    
    init(apiClient: BothamAPIClient, parser: DIDsParser) {
        self.apiClient = apiClient
        self.parser = parser
    }
    
    
    
    /*
    portnumber    Telephone number to port    Yes    10 digit number
    endportnumber    End Sequential Telephone number to port    No    10 digit number
    partial    Partial Port Indicator    Yes    yes/no
    additional    If partial port order is yes this is required    No    Note of what should happen to remaining services
    wireless    Wireless Port Indicator    Yes    yes/no
    ssnpin    If wireless port order is yes this is required.    No    last_four_ssn:account_pin_code
    carrier    Current Provider    Yes    Current provider name
    company    End user company name    Yes    End user company name
    accnumber    Account number with current provider    Yes    Account number with current provider
    name    End user name    Yes    End user name
    streetnumber    Street Number of End user address    Yes    Street Number of End user address
    streetprefix    Directional Prefix for End user address street name    No    N/W/E/S, etc
    streetname    Street Name of End user address    Yes    Street Name of End user address
    streetsuffix    Directional Suffix for End user address street name    No    N/W/E/S, etc
    unit    End user address Suite, Unit, Apt number    No    Suite XXX, etc
    city    City of End user address    Yes    City name
    state    State of End user address    Yes    2 Letter State Abbreviation
    zip    Zip Code of End user address    Yes    5 digit Zip Code
    billnumber    Billing Telephone Number associated with current provider for DID    Yes    10 digit number
    contactnumber    Contact Telephone Number for any questions    Yes    10 digit number
    routeto    Specify Sub Account / Host for default route upon port completion    No    sub account or IP address
    rateplan    Specify Rateplan for Port Order. PPM is default.    No    ppm/unlim/vfax
    porttype    Specify type of port, residential or business. Business is default    No    residential/business
    xml    Sending xml=yes will return your results as XML instead of plain text    No    yes */
    
    public func addPort(portnumber : Int, partial : Bool, partialNotes : String = "", wireless : Bool, ssnpin : String = "", currentProvider : String,
                        endUserCompanyName : String, currentProviderAccNumber : String, name : String, streetNumber : String, streetName : String, streetsuffix : String?,
                        streetPrefix : String?, unit : String?, city : String, State : String, Zip : Int, billingNumber : Int, contactnumber : Int, routeto : String?, ratePlan : RatePlanType = .ppm,
                        portType : PortType = .business,
                        completion: @escaping (Result<Bool, BothamAPIClientError>) -> Void) {
        
        var params = [ "cmd" : "addport",
                       "portnumber" : "\(portnumber)",
                       "carrier" : currentProvider,
                       "company" : endUserCompanyName,
                       "accnumber": "\(currentProviderAccNumber)",
                       "endUserName" : name,
                        "streetnumber" : "\(streetNumber)",
                        "streetname": streetName,
                        "city": city,
                        "state": State,
                        "zip": "\(Zip)",
                        "billnumber": "\(billingNumber)",
                        "contactnumber": "\(contactnumber)",
            ]
        
        if routeto != nil{
            params["routeto"] = routeto ?? ""
        }
        
        params["rateplan"] = ratePlan.rawValue
        params["porttype"] = portType.rawValue
        
        params["partial"] = "no"
        if partial {
            params["partial"] = "yes"
            params["additional"] = partialNotes
        }
        
        params["wireless"] = "no"
        if wireless {
            params["wireless"] = "yes"
            params["ssnpin"] = ssnpin
        }
        
        if streetsuffix != nil {
             params["streetsuffix"] = streetsuffix
        }
        
        if streetPrefix != nil {
            params["streetprefix"] = streetPrefix
        }
        
        if unit != nil {
            params["unit"] = unit
        }
        
        apiClient.GET("", parameters: params) { response in
            completion(
                response.mapXML {
                    return self.parser.successFromXml(xml: $0)
                }
            )
        }
    }
        
}


