//
//  ContributersViewController.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 16/02/22.
//

import UIKit

class ContributorsViewController: UIViewController, ContributorsViewModalDelegate {
    
    // MARK: Stored Properties
    var contributorsViewModal = ContributorsViewModal(contributors: FetchUserRepository())
    var userName = ""
    var repoName = ""
    // MARK: Outlets
    @IBOutlet weak var contributorsTableView: UITableView!
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        contributorsTableView.delegate = self
        contributorsTableView.dataSource = self
        contributorsViewModal.delegate = self
        
        contributorsViewModal.fetchUserContributorsData(user: userName, repo: repoName)
    }
    
    // MARK: Conforming to ContributorsFetchApiDelegate Protocol
    func updateContributorsAfterFetchUserData() {
        DispatchQueue.main.async {
            if(!self.contributorsViewModal.contributorsList.isEmpty){
                self.contributorsTableView.reloadData()
            }
        }
    }
}

extension ContributorsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contributorsViewModal.contributorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contributorsTableView.dequeueReusableCell(withIdentifier: "ContributorsTableViewCell") as! ContributorsTableViewCell
        let repoList = contributorsViewModal.contributorsList[indexPath.row]
        cell.setData(contributorsList: repoList)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        VC.user = contributorsViewModal.contributorsList[indexPath.row].name!
        navigationController?.pushViewController(VC, animated: true)
        
        contributorsTableView.deselectRow(at: indexPath, animated: true)
    }
}

