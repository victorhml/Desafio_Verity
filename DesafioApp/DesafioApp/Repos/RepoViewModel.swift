//
//  RepoViewModel.swift
//  DesafioApp
//
//  Created by Victor Hugo Martins Lisboa on 18/08/23.
//

import Foundation

class RepoViewModel {
    
    func getReposList(urlString: String, completion: @escaping ([RepoModel]) -> Void) {
        let url = URL(string: urlString + "1")
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let repos = try decoder.decode([RepoModel].self, from: data)
                DispatchQueue.main.async {
                    completion(repos)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        task.resume()
    }
    
}
