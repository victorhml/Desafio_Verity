//
//  UserInfoViewModel.swift
//  DesafioApp
//
//  Created by Victor Hugo Martins Lisboa on 18/08/23.
//

import Foundation
import UIKit

class UserInfoViewModel {
    
    func getUserInfo(urlString: String, completion: @escaping (UserInfoModel?) -> Void) {
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let userInfo = try decoder.decode(UserInfoModel.self, from: data)
                DispatchQueue.main.async {
                    completion(userInfo)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
    
    func goToRepos(navigationController: UINavigationController, currentUserInfo: UserInfoModel) {
        let coordinator = RepoCoordinator(navigationController: navigationController)
        coordinator.currentUserInfo = currentUserInfo
        coordinator.start()
    }
}
