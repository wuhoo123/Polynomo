//
//  GetSpecificBillData.swift
//  Polynomo
//
//  Created by William Wu on 7/21/21.
//

import Foundation

struct SpecificBillJSONFormat: Codable {
    let status: String
    let results: [ResultsGetSpecificBillData]
    
}

struct ResultsGetSpecificBillData: Codable {
    let sponsor: String
    let sponsor_id: String
    let title: String
    let short_title: String
    let summary: String
    
}
