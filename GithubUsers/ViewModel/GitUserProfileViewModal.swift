//
//  FetchURL.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 06/02/22.
//

import Foundation

// Function to set data fetched from URL

// ===========================  Using URLSession ==========================
// ========================================================================

protocol GitUserProfileDelegate{
    func updateUIAfterFetchUserData()
    func updateRepoAfterFetchUserData()
    func updateUIAfterUserNotFound()
}

class GitUserProfileViewModal{
    
    // MARK: Stored Properties
    var repoList = [RepoModal]()
    var repository: RepositoryProtocol?
    var userData: UserModal?
    var delegate: GitUserProfileDelegate?
    let userProperties = ["repositories", "stars", "followers", "following"]
    var userPropertiesData = [Int]()
    
    init(repository: RepositoryProtocol){
        self.repository = repository
    }
    
    // MARK: Setting user data
    func fetchUserData(user: String){
        repository?.fetchUserData(user: user) {[weak self] (status, data, error) in
            if status{
                self?.userData = data
                self?.userPropertiesData.append((self?.userData?.repoCount ?? 0))
                self?.userPropertiesData.append(50)
                self?.userPropertiesData.append((self?.userData?.followers ?? 0))
                self?.userPropertiesData.append((self?.userData?.followings ?? 0))
                
                if let userImage = self?.userData?.userImgURL{
                    self?.fetchUserImage(urlString: userImage)
                }
                self?.delegate?.updateUIAfterFetchUserData()
            }
            else{
                self?.delegate?.updateUIAfterUserNotFound()
                print("System Error")
            }
        }
    }
    
    // MARK: Fetching user image
    func fetchUserImage(urlString: String){
        guard let url = URL(string: urlString) else { return  }
        let data = try? Data(contentsOf: url)

        if let imageData = data {
            self.userData?.imgData = imageData
        }
    }
    
    // MARK: Setting user data
    func fetchUserRepoData(user: String){
        repository?.fetchUserRepoData(user: user) {[weak self] (status, data, error) in
            if status {
                if let data = data{
                    self?.repoList.append(contentsOf: data)
                    self?.delegate?.updateRepoAfterFetchUserData()
                }
                else{
                    print(error ?? "System Error")
                }
            }
            else{
                print(error ?? "System Error")
            }
        }
    }
}
// ==========================  END  ==============================
//                            *****



