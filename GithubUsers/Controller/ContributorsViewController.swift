//
//  ContributersViewController.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 16/02/22.
//

import UIKit

class ContributorsViewController: UIViewController, ContributorsViewModalDelegate {
    
    // MARK: Stored Properties
    var userName = ""
    var repoName = ""
    var contributorsViewModal = ContributorsViewModal(contributors: FetchUserRepository())

    // MARK: Outlets
    @IBOutlet weak var contributorsTableView: UITableView!
    @IBOutlet weak var contributorNotFoundView: UIView!
    @IBOutlet weak var contributorNotFoundText: UILabel!
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        contributorsTableView.delegate = self
        contributorsTableView.dataSource = self
        contributorsViewModal.delegate = self
        // MARK: Fetching the list of contributors of selected repo
        contributorsViewModal.fetchUserContributorsData(user: userName, repo: repoName)
    }
    
    // MARK: Conforming to ContributorsFetchApiDelegate Protocol
    func updateContributorsAfterFetchUserData() {
        DispatchQueue.main.async {
            if(!self.contributorsViewModal.contributorsList.isEmpty){
                self.contributorsTableView.reloadData()
            }
            else{
                // MARK: Handling no contributors found -> kudoleh, SaleForceSDKTestDemo
                self.contributorNotFoundView.isHidden = false
            }
        }
    }
}

// MARK: Extension for  delegate and datasource
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
    
    // MARK: Navigating to selected contributor's profile
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        VC.user = contributorsViewModal.contributorsList[indexPath.row].name!
        navigationController?.pushViewController(VC, animated: true)
        contributorsTableView.deselectRow(at: indexPath, animated: true)
    }
}

