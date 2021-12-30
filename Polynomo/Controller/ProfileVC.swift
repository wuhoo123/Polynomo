//
//  ProfileViewC.swift
//  Polynomo
//
//  Created by William Wu on 12/27/21.
//

import Foundation
import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var NameText: UILabel!
    @IBOutlet weak var IDText: UILabel!
    @IBOutlet weak var GenderText: UILabel!
    @IBOutlet weak var Spinner: UIActivityIndicatorView!
    
    var sponsor_id: String?
    var MemberManager = GetMember()
    var member: MemberModel = MemberModel(id: " ", first_name: " ", last_name: " ", gender: " ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MemberManager.delegate = self
        MemberManager.fetchMember(id: sponsor_id ?? "")
        
        Spinner.hidesWhenStopped = true
        Spinner.startAnimating()

    }
}

//MARK: - GetMemberDelegate
extension ProfileVC: GetMemberDelegate {
    func didUpdateStatus(_ getMember: GetMember, member: MemberModel) {
//        let group = DispatchGroup()
//        group.enter()
        
        DispatchQueue.main.async {
            self.NameText.text = member.first_name + " " + member.last_name
            self.IDText.text = member.id
            self.GenderText.text = member.gender
            self.Spinner.stopAnimating()
            // group.leave()
        }
        
//        group.notify(queue: .main) {
//            print(member)
//        }
    }
    
    func didFailWithError(_ error: Error) {
        print("ei")
        print(error)
    }
}
