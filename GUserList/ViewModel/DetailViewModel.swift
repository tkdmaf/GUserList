//
//  DetailViewModel.swift
//  GUserList
//
//  Created by 蕭文安 on 2020/3/12.
//  Copyright © 2020 蕭文安. All rights reserved.
//

import UIKit

class DetailViewModel {
    
    public weak var vc: DetailViewController?
    public var login: String?
    let downloadImageQueue = OperationQueue()
    var onImageDownloaded: ((UIImage?) -> Void)?
    
    public func prepareRequest() {
        guard let login = self.login else {
            return
        }
        moyaProvider.request(.user(login: login)) { (result) in
            switch result {
                
            case .success(let response):
                let data = try! JSONDecoder().decode(GHUser.self, from: response.data)
                self.convertUserToViewModel(user: data)
                break
                
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
                break
           
            }
        }
    }
    
    private func convertUserToViewModel(user: GHUser) {
        guard let vc = self.vc else {
            return
        }
        vc.fullName.text = user.name
        vc.login.text = user.login
        vc.bio.text = user.bio
        vc.city.text = user.location
        vc.link.text = user.blog
        getImage(user.avatar_url)
    }
    
    private func getImage(_ imageUrl: String?) {
        guard let imageUrl = imageUrl else { return }
        guard let url = URL(string: imageUrl) else { return }
        downloadImageQueue.addOperation { [weak self] in
            
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                guard let imageDownloaded = self?.onImageDownloaded else { return }
                imageDownloaded(image)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
    }
    
}
