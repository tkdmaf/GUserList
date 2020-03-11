//
//  UserListCell.swift
//  GUserList
//
//  Created by 蕭文安 on 2020/3/11.
//  Copyright © 2020 蕭文安. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var login: UILabel!
    
    private var viewModel: UserListCellViewModel?
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.origin.x += 2
            frame.size.width -= 4
            frame.origin.y += 2
            frame.size.height -= 4
            super.frame = frame
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 2.0
        self.avatarImage.layer.cornerRadius = 30.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
        self.viewModel?.onImageDownloaded = nil
    }
    
    func setup(viewModel: UserListCellViewModel) {
        self.viewModel = viewModel
        self.login.text = viewModel.login
        
        self.viewModel?.onImageDownloaded = { [weak self] image in
            DispatchQueue.main.async {
                self?.avatarImage.image = image
            }
        }
        self.viewModel?.getImage()
    }
    

}
