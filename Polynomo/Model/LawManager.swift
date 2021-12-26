//
//  LawManager.swift
//  Polynomo
//
//  Created by William Wu on 7/21/21.
//

// The LawManager.swift is responsible for parsing the JSON data from the ProPublica API with both GET requests for upcoming laws and bills and the specific bill data.


import Foundation

// This delegate
protocol LawManagerDelegate {
    func didUpdateStatus(_ lawManager: LawManager, upcoming: [PostModel])
    func didFailWithError(_ error: Error)
}

struct LawManager {
    
    // URL String for upcoming bills.
    let urlUpcomingString = "https://api.propublica.org/congress/v1/bills/upcoming/house.json"
    
    // URL String for getting data on a specific bill.
    let urlGetSpecificBillString = "https://api.propublica.org/congress/v1/117/bills/"
    
    // Creating the delgate member
    var delegate: LawManagerDelegate?

    
    
    // Calls API and sets the authorization header for upcoming data.
    func fetchUpcoming(_ id: Int) {
        var urlUpcomingFinalString: String?
        
//        if id == 0{
//            urlUpcomingFinalString = urlUpcomingString + "senate.json"
//        } else if id == 1 {
//            urlUpcomingFinalString = urlUpcomingString + "house.json"
//        }
        
        let urlUpcoming = NSURL(string: urlUpcomingString)!
        let request = NSMutableURLRequest(url: urlUpcoming as URL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(Constant.APIKEY, forHTTPHeaderField: "X-API-Key")
        
        performRequest(request, 0)
    }

    // Calls API and sets the authorization header for specific data.
    func getSpecificBill(_ bill_slug: [String]) {
        let length = bill_slug.count
        for i in 0...length-1 {
            print(bill_slug[i])
            let urlGetSpecificBill = NSURL(string: urlGetSpecificBillString + bill_slug[i] + ".json")!
            print(urlGetSpecificBill)
            let request = NSMutableURLRequest(url: urlGetSpecificBill as URL)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(Constant.APIKEY, forHTTPHeaderField: "X-API-Key")
            performRequest(request, 1)
        }
    }
    
    // Creates a URL Session
    func performRequest(_ urlRequest: NSURLRequest, _ id: Int) {

        let session = URLSession.shared.dataTask(with: urlRequest as URLRequest) {data, response, error in
            if error != nil {
                self.delegate?.didFailWithError(error!)
                print("No")
                return
            }
            if let safeData = data {
                if id == 0 {
                    self.parseJSONUpcoming(safeData)
                }
                if id == 1 {
                    if let post = self.parseJSONSpecific(safeData) {
                        self.delegate?.didUpdateStatus(self, upcoming: post)
                        
                    }
                }
            
            }
        }
        session.resume()

    }
    
    // Parses the JSON Data for Upcoming Bills GET Request.
    func parseJSONUpcoming(_ lawData: Data){
        var upcomingBill: [String] = []
        let decoder = JSONDecoder()
        
        do {
            let decodedDataUpcoming = try decoder.decode(UpcomingData.self, from: lawData)
            let length = decodedDataUpcoming.results[0].bills.count
            
            for i in 0...length-1 {
                let bill_slug = decodedDataUpcoming.results[0].bills[i].bill_slug
                upcomingBill.append(bill_slug)
            }
            
            self.getSpecificBill(upcomingBill)
            
        }
        catch {
            self.delegate?.didFailWithError(error)
            print("error")
        }
    }
    
    // Parses the JSON Data for Specific Bill GET Request.
    func parseJSONSpecific(_ lawData: Data) -> [PostModel]?{
        
        var post: [PostModel] = []
        
        let decoder = JSONDecoder()
                
        do {
                
            let decodedDataGetSpecific = try decoder.decode(UpcomingJSONFormat.self, from: lawData)
            let short_title = decodedDataGetSpecific.results[0].short_title
            let title = decodedDataGetSpecific.results[0].title
            let summary = decodedDataGetSpecific.results[0].summary
            let sponsor = decodedDataGetSpecific.results[0].sponsor
            let postItem = PostModel(title: title, shortTitle: short_title, summary: summary, billSponsor: sponsor)
            post.append(postItem)
            //print(post)
            return post
            
        } catch {
            self.delegate?.didFailWithError(error)
            print("error")
            return nil
        }
        
    }
    
}
