//
//  ContributorsFetchApiViewModel.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 15/02/22.
//

import Foundation

protocol ContributorsViewModalDelegate{
    func updateContributorsAfterFetchUserData()
}

class ContributorsViewModal{
    var contributorsList = [ContributorModal]()
    var delegate: ContributorsViewModalDelegate?
    var contributors: RepositoryProtocol?
    
    init(contributors: RepositoryProtocol){
        self.contributors = contributors
    }
    
    // MARK: Function for fetching user data
    func fetchUserContributorsData(user: String, repo: String){
        contributors?.fetchUserContributorsData(user: user, repo: repo, completionHandler: { status, data, error in
            if let data = data {
                self.contributorsList.append(contentsOf: data)
                self.delegate?.updateContributorsAfterFetchUserData()
            }
            
        })
    }
}
