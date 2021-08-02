//
//  HomeViewController.swift
//  Polynomo
//
//  Created by William Wu on 7/21/21.
//

import Foundation
import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var lawManager = LawManager()
    
    var post: [PostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        lawManager.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register the xib file to those cells.
        tableView.register(UINib(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.cellIdentifier)
        
        lawManager.fetchUpcoming(1)
        loadPosts()
        
    }
    
    // Function that hides the navigation bar.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = false  // Shows the navigation bar
    }
    
    func loadPosts() {
        tableView.reloadData()
    }
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        print("logout pressed")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("success")
            self.performSegue(withIdentifier: "Logout", sender: self)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
    
}

//MARK: - LawManagerDelegate
extension HomeViewController: LawManagerDelegate {
    func didUpdateStatus(_ lawManager: LawManager, upcoming: [PostModel]) {
        DispatchQueue.main.async {
            self.post.append(upcoming[0])
            self.loadPosts()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    
}

//MARK: - UITableViewDataSource

// This function runs to many times at once to update the data. It loads the table n times if there are n elements instead of just once. Needs to be fixed.

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(post.count)
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postData = post[indexPath.row]
        print(postData)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath) as! PostViewCell
        
        cell.shortTitleText.text = postData.shortTitle
        cell.sponsorButton.setTitle("👤 \(postData.billSponsor)", for: .normal)
        
        if postData.summary == "" {
            cell.shortSummaryText.text = "Summary is not available yet."
        }
        else {
            cell.shortSummaryText.text = postData.summary
        }
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FeedToPost", sender: self)
        print(indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FeedToPost" {
            if let destination = segue.destination as? DetailViewController{
                destination.post = post[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
}
