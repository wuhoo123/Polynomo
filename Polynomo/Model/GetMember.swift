//
//  GetMember.swift
//  Polynomo
//
//  Created by William Wu on 12/27/21.
//

import Foundation

protocol GetMemberDelegate {
    func didUpdateStatus(_ getMember: GetMember, member: MemberModel)
    func didFailWithError(_ error: Error)
}

struct GetMember {
    // GET https://api.propublica.org/congress/v1/members/{member-id}.json
    let getMemberString = "https://api.propublica.org/congress/v1/members/"
    
    var delegate: GetMemberDelegate?
    
    // Forms URL and the request
    func fetchMember(id: String) {
        let getMemberStringFinal = getMemberString + id + ".json"
        let urlMember = NSURL(string: getMemberStringFinal)!
        let request = NSMutableURLRequest(url: urlMember as URL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(Constant.APIKEY, forHTTPHeaderField: "X-API-Key")
        
        performRequest(request)
    }
    
    // Performs request
    func performRequest(_ urlRequest: NSURLRequest) {
        let session = URLSession.shared.dataTask(with: urlRequest as URLRequest) {data, response, error in
            if error != nil {
                self.delegate?.didFailWithError(error!)
                print("No")
                return
            }
            if let safeData = data {
                if let mem = self.parseJSONMember(safeData) {
                    self.delegate?.didUpdateStatus(self, member: mem)
                    
                }
            }
        }
        session.resume()
    }
    
    // Parsing JSON
    func parseJSONMember(_ memberData: Data) -> MemberModel?{
        
        let decoder = JSONDecoder()
                
        do {
            let decodedDataGetMember = try decoder.decode(MemberJSONFormat.self, from: memberData)
            
            let id = decodedDataGetMember.results[0].id
            let first_name = decodedDataGetMember.results[0].first_name
            let last_name = decodedDataGetMember.results[0].last_name
            let gender = genderAssignment(gender: decodedDataGetMember.results[0].gender)
            let current_party = partyAssignment(party: decodedDataGetMember.results[0].current_party) 
            
            let congress = decodedDataGetMember.results[0].roles[0].congress
            let total_votes = decodedDataGetMember.results[0].roles[0].total_votes
            let missed_votes = decodedDataGetMember.results[0].roles[0].missed_votes
            let total_present = decodedDataGetMember.results[0].roles[0].total_present
            let bills_sponsored = decodedDataGetMember.results[0].roles[0].bills_sponsored
            let bills_cosponsored = decodedDataGetMember.results[0].roles[0].bills_cosponsored
            let missed_votes_pct = decodedDataGetMember.results[0].roles[0].missed_votes_pct
            let votes_with_party_pct = decodedDataGetMember.results[0].roles[0].votes_with_party_pct
            
            let memberItem = MemberModel(id: id, first_name: first_name, last_name: last_name, gender: gender, current_party: current_party, congress: congress, total_votes: total_votes, missed_votes: missed_votes, total_present: total_present, bills_sponsored: bills_sponsored, bills_cosponsored: bills_cosponsored, missed_votes_pct: missed_votes_pct, votes_with_party_pct: votes_with_party_pct)
            return memberItem
            
        } catch {
            self.delegate?.didFailWithError(error)
            print("error")
            return nil
        }
    }
    
    func genderAssignment(gender: String) -> String {
        if gender == "F" {
            return "Female"
        }
        else {
            return "Male"
        }
    }
    
    func partyAssignment(party: String) -> String {
        if party == "D" {
            return "Democratic Party"
        }
        else if party == "R" {
            return "Republican Party"
        }
        return ""
    }
    
    
}
