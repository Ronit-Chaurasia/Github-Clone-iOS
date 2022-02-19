//
//  Repository.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 17/02/22.
//

import Foundation

protocol RepositoryProtocol {
    func fetchUserData(user: String, completionHandler: @escaping (_ status: Bool, _ data: UserModal?, _ error: String?)->Void)
    func fetchUserRepoData(user: String, completionHandler: @escaping (_ status: Bool, _ data: [RepoModal]?, _ error: String?)->Void)
    func fetchUserContributorsData(user: String, repo: String, completionHandler: @escaping (_ status: Bool, _ data: [ContributorModal]?, _ error: String?)->Void)
}

class FetchUserRepository: RepositoryProtocol{
    
    // MARK: Fetching User Profile Data
    func fetchUserData(user: String, completionHandler: @escaping (_ status: Bool, _ data: UserModal?, _ error: String?)->Void){
        
        if let url = URL(string: "https://api.github.com/users/" + user){
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                if let error = error {
                    completionHandler(false, nil, String(describing: error))
                    return
                }
                do {
                    if let data = data{
                        let result = try JSONDecoder().decode(UserModal.self, from: data)
                        if result.userName == nil{
                            completionHandler(false, nil, String(describing: error))
                        }
                        completionHandler(true, result, nil)
                    }
                } catch {
                    completionHandler(false, nil, String(describing: error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: Fetching User Repo Data
    func fetchUserRepoData(user: String,  completionHandler: @escaping (_ status: Bool, _ data: [RepoModal]?, _ error: String?)->Void){
        
        if let url = URL(string: "https://api.github.com/users/" + user + "/repos"){
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                if let error = error {
                    completionHandler(false, nil, error.localizedDescription)
                    return
                }
                do {
                    if let data = data {
                        let result = try JSONDecoder().decode([RepoModal].self, from: data)
                        completionHandler(true, result, nil)
                    }
                    
                } catch {
                    completionHandler(false, nil, error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    // MARK: Fetching Repo Contributors Data
    func fetchUserContributorsData(user: String, repo: String, completionHandler: @escaping (_ status: Bool, _ data: [ContributorModal]?, _ error: String?)->Void){
       
        if let url = URL(string:"https://api.github.com/repos/" + user + "/" + repo + "/contributors"){
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    completionHandler(false, nil, error.localizedDescription)
                    return
                }
                do {
                    if let data = data {
                        let result = try JSONDecoder().decode([ContributorModal].self, from: data)
                        completionHandler(true, result, nil)
                    }
                } catch {
                    completionHandler(false, nil, error.localizedDescription)
                }
            }
            task.resume()
        }
    }
}
