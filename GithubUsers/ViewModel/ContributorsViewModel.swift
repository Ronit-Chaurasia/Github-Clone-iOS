//
//  ContributorsFetchApiViewModel.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 15/02/22.
//

import Foundation

protocol ContributorsViewModalDelegate{
    func updateContributorsAfterFetchUserData()
    func updateContributorsAfterContributorsNotFound()
}

class ContributorsViewModal{
    var contributorsList = [ContributorModal]()
    var delegate: ContributorsViewModalDelegate?
    var contributors: RepositoryProtocol?
    var errorInFetchingList = false
    
    init(contributors: RepositoryProtocol){
        self.contributors = contributors
    }
    
    // MARK: Function for fetching user data
    func fetchUserContributorsData(user: String, repo: String){
        contributors?.fetchUserContributorsData(user: user, repo: repo, completionHandler: { status, data, error in
            if let data = data {
                self.contributorsList = data
                self.errorInFetchingList = false
                self.delegate?.updateContributorsAfterFetchUserData()
            }
            else{
                self.errorInFetchingList = true
                self.delegate?.updateContributorsAfterContributorsNotFound()
            }
        })
    }
}
