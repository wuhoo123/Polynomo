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
            
            var gender: String
            if decodedDataGetMember.results[0].gender == "F" {
                gender = "Female"
            }
            else {
                gender = "Male"
            }
            print(first_name)
            
            let memberItem = MemberModel(id: id, first_name: first_name, last_name: last_name, gender: gender)
            return memberItem
            
        } catch {
            self.delegate?.didFailWithError(error)
            print("error")
            return nil
        }
    }
    
    
}
