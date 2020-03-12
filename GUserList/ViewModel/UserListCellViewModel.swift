//
//  UserListCellViewModel.swift
//  GUserList
//
//  Created by 蕭文安 on 2020/3/11.
//  Copyright © 2020 蕭文安. All rights reserved.
//

import UIKit

class UserListCellViewModel {
    
    var avatar_url: String?
    var login: String?
    var cellIdentifier: String!
    
    private let downloadImageQueue = OperationQueue()
    
    var onImageDownloaded: ((UIImage?) -> Void)?
    
    func getImage() {
        guard let imageUrl = avatar_url else { return }
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
