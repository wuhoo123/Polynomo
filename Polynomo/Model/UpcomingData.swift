//
//  UpcomingData.swift
//  Polynomo
//
//  Created by William Wu on 7/21/21.
//

import Foundation


struct UpcomingData: Codable {
    let copyright: String
    let results: [Results]
}

struct Results: Codable {
    let date: String
    let bills: [Bills]
}

struct Bills: Codable {
    let bill_slug: String
    let bill_number: String
    let scheduled_at: String
    
}
