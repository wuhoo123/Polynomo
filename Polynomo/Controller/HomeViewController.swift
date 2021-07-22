//
//  HomeViewController.swift
//  Polynomo
//
//  Created by William Wu on 7/21/21.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var lawManager = LawManager()
    
    var post: [PostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lawManager.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register the xib file to those cells.
        tableView.register(UINib(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.cellIdentifier)
        
//        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = 200 // replace 50 with whatever height you require
//        self.tableView.reloadData()
        
        lawManager.fetchUpcoming(1)
        loadPosts()
        
    }
    
    // Function that hides the navigation bar.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false  // Shows the navigation bar
    }
    
    func loadPosts() {
        tableView.reloadData()
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
