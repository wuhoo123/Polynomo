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
    
    var MemberManager = GetMember()
    var member: MemberModel = MemberModel(id: " ", first_name: "hi ", last_name: " ", gender: " ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MemberManager.delegate = self
        MemberManager.fetchMember()
        

    }
    
    
}

//MARK: - GetMemberDelegate
extension ProfileVC: GetMemberDelegate {
    func didUpdateStatus(_ getMember: GetMember, member: MemberModel) {
        DispatchQueue.main.async {
            self.NameText.text = member.first_name + " " + member.last_name

        }

    }
    
    
    func didFailWithError(_ error: Error) {
        print("ei")
        print(error)
    }
    
    
}

