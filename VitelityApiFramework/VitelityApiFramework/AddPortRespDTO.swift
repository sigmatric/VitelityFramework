//
//  AddPortRespDTO.swift
//  VitelityClient
//
//  Created by Jorge Enrique Dominguez on 10/20/18.
//  Copyright © 2018 sigmatric. All rights reserved.
//

import Foundation

public struct AddPortResponseDTO {
    public let portid: String
    public let signatureRequired : Bool
    public let billRequired : Bool
}
