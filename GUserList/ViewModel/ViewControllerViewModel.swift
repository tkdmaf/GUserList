//
//  ViewModel.swift
//  GUserList
//
//  Created by 蕭文安 on 2020/3/11.
//  Copyright © 2020 蕭文安. All rights reserved.
//

import Foundation

class ViewControllerViewModel {
    
    var onRequestEnd: (() -> Void)?
    
    var listCellViewModels: [UserListCellViewModel] = []
    
    public func prepareRequest() {
        moyaProvider.request(.users(since: 0, per_page: 100)) { (result) in
            switch result {
               
            case .success(let response):
                let data = try! JSONDecoder().decode([GHUser].self, from: response.data)
                self.convertUserToViewModel(users: data)
                break
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
                break
          
            }
        }
        
    }
    
    private func convertUserToViewModel(users: [GHUser]) {
        for user in users {
            let cellIdentifier = (user.type == "User") ? "UserListCell" : "AdminUserListCell"
            let listCellViewModel = UserListCellViewModel()
            listCellViewModel.avatar_url = user.avatar_url
            listCellViewModel.login = user.login
            listCellViewModel.cellIdentifier = cellIdentifier
            listCellViewModels.append(listCellViewModel)
        }
        onRequestEnd?()
    }
    
}
