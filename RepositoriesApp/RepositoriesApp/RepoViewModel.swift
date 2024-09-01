//
//  RepoViewModel.swift
//  RepositoriesApp
//
//  Created by Mariam Abdelhamid on 8/31/24.
//

import Foundation
import RxSwift

class RepoViewModel {
    
    var repoServiceApi : RepoServiceApiProtocol
    var repoItems = BehaviorSubject<[Item]>(value: [])
    var errorHandling = BehaviorSubject<Error>(value: RepoError.badUrl)
    init(repoServiceApi: RepoServiceApiProtocol) {
        self.repoServiceApi = repoServiceApi
    }
    
    func getRepoData(searchText: String) {
        Task{
            do {
                guard let items = try await repoServiceApi.searchRepoService(searchedText: searchText).items else { 
                    DispatchQueue.main.async {
                        self.errorHandling.onNext(RepoError.failedFetchData)
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.repoItems.onNext(items)
                }
                    
            } catch {
                DispatchQueue.main.async {
                    self.errorHandling.onNext(RepoError.badServerResponse)
                }
            }
     
        }
    }
    
}
