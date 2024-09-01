//
//  RepoServiceApi.swift
//  RepositoriesApp
//
//  Created by Mariam Abdelhamid on 8/31/24.
//

import Foundation


enum RepoError: Error {
    case badUrl
    case badServerResponse
    case failedFetchData
}
protocol RepoServiceApiProtocol {
    func searchRepoService(searchedText: String) async throws -> RepoModel
}

class RepoServiceApi: RepoServiceApiProtocol {
    
    let mainUrl = "https://api.github.com/search/repositories?q="
    
    func searchRepoService(searchedText: String) async throws -> RepoModel {
        
        guard let url = URL(string: mainUrl + searchedText) else {
            throw RepoError.badUrl
        }
        
        do {
            let data = try await fetchData(from: url)
            return try JSONDecoder().decode(RepoModel.self, from: data)
        } catch {
            throw RepoError.failedFetchData
        }
        
        
    }
    
    private func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
    
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw RepoError.badServerResponse
        }
        return data
    }
    
    
}
