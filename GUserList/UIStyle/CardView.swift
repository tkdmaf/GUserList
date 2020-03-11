//
//  CardView.swift
//  GUserList
//
//  Created by 蕭文安 on 2020/3/11.
//  Copyright © 2020 蕭文安. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
