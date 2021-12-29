//
//  MemberJSONFormat.swift
//  Polynomo
//
//  Created by William Wu on 12/26/21.
//

import Foundation

struct MemberJSONFormat: Codable {
    let status: String
    let results: [ResultsMember]
}

struct ResultsMember: Codable {
    let id: String
    let first_name: String
    let last_name: String
    let gender: String
    // let roles: [MemberRoles]
}

struct MemberRoles {
    
}
