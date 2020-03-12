//
//  DetailViewController.swift
//  GUserList
//
//  Created by 蕭文安 on 2020/3/12.
//  Copyright © 2020 蕭文安. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet var headerImage: UIImageView!
    @IBOutlet var fullName: UILabel!
    @IBOutlet var adminLogin: UILabel!
    @IBOutlet var bio: UILabel!
    @IBOutlet var login: UILabel!
    @IBOutlet var city: UILabel!
    @IBOutlet var link: UILabel!
    
    @IBOutlet var staffImage: UILabel!
    

    let viewModel: DetailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerImage.layer.cornerRadius = self.view.frame.size.width / 4
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.vc = self
        viewModel.prepareRequest()
        viewModel.onImageDownloaded = {[weak self] image in
            DispatchQueue.main.async {
                self?.headerImage.image = image
            }
        }
    }
    
    @IBAction func backPage(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
