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
    let current_party: String
    let roles: [MemberRoles]
}

struct MemberRoles: Codable {
    let congress: String
    let total_votes: Int
    let missed_votes: Int
    let total_present: Int
    let bills_sponsored: Int
    let bills_cosponsored: Int
    let missed_votes_pct: Double
    let votes_with_party_pct: Double
    // let votes_against_party_pct: Int
}
