//
//  UserViewModel.swift
//  DesafioApp
//
//  Created by Victor Hugo Martins Lisboa on 18/08/23.
//

import Foundation
import UIKit

class UserViewModel {
    
    func getUsersList(completion: @escaping ([UserModel]) -> Void) {
        
        let url = URL(string: "https://api.github.com/users")
        
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
                let users = try decoder.decode([UserModel].self, from: data)
                DispatchQueue.main.async {
                    completion(users)
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
    
    func goToUserInfo(navigationController: UINavigationController, currentUser: UserModel) {
        let coordinator = UserInfoCoordinator(navigationController: navigationController)
        coordinator.currentUser = currentUser
        coordinator.start()
    }
}
