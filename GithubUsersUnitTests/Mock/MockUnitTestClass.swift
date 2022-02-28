//
//  MockUnitTestClass.swift
//  GithubUsersUnitTests
//
//  Created by Ronit Chaurasia on 23/02/22.
//

import Foundation
@testable import GithubUsers

class MockData{
    
    // MARK: Variable to check error
    var shouldReturnError = false
    var fileName: String 
    
    init(_ fileName: String){
        self.fileName = fileName
    }
    
    // MARK: enum to handle error
    enum MockingServiceError: Error{
        case user
        case repo
        case contributors
    }
    
    func readLocalFile(forName name: String, _ completion: @escaping ((Data?) -> Void)) {
        if let path = Bundle(for: MockData.self).path(forResource: name, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                completion(data)
            } catch _ {
                completion(nil)
            }
        }
    }
    
    func parseToUserModal(jsonData: Data) -> UserModal? {
        do {
            let decodedData = try JSONDecoder().decode(UserModal.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error in user modal")
            return nil
        }
    }
    
    func parseToRepoModal(jsonData: Data) -> [RepoModal]? {
        do {
            let decodedData = try JSONDecoder().decode([RepoModal].self, from: jsonData)
            return decodedData
        } catch {
            print("decode error in repo modal")
            return nil
        }
    }
    
    func parseToContributorModal(jsonData: Data) -> [ContributorModal]? {
        do {
            let decodedData = try JSONDecoder().decode([ContributorModal].self, from: jsonData)
            return decodedData
        } catch {
            print("decode error in repo modal")
            return nil
        }
    }
}

extension MockData: RepositoryProtocol{
    
    func fetchUserData(user: String, completionHandler: @escaping (Bool, UserModal?, String?) -> Void) {
        readLocalFile(forName: fileName) {[weak self] data in
            guard let data = data else{
                completionHandler(false, nil, String(describing: MockingServiceError.user))
                return
            }
            
            if let parsedData = self?.parseToUserModal(jsonData: data){
                completionHandler(true, parsedData, nil)
            }
            
            else{
                completionHandler(false, nil, String(describing: MockingServiceError.user))
            }
        }
    }
    
    func fetchUserRepoData(user: String, completionHandler: @escaping (Bool, [RepoModal]?, String?) -> Void) {
        
        readLocalFile(forName: fileName) {[weak self] data in
            guard let data = data else{
                completionHandler(false, nil, String(describing: MockingServiceError.user))
                return
            }
            if let parsedData = self?.parseToRepoModal(jsonData: data){
                completionHandler(true, parsedData, nil)
            }
            else{
                completionHandler(false, nil, String(describing: MockingServiceError.user))
            }
        }
    }
    
    func fetchUserContributorsData(user: String, repo: String, completionHandler: @escaping (Bool, [ContributorModal]?, String?) -> Void) {
        readLocalFile(forName: fileName) {[weak self] data in
            guard let data = data else{
                completionHandler(false, nil, String(describing: MockingServiceError.user))
                return
            }
            if let parsedData = self?.parseToContributorModal(jsonData: data){
                completionHandler(true, parsedData, nil)
            }
            else{
                completionHandler(false, nil, String(describing: MockingServiceError.user))
            }
        }
    }
}
