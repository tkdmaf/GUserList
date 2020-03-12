//
//  ViewController.swift
//  GUserList
//
//  Created by 蕭文安 on 2020/3/11.
//  Copyright © 2020 蕭文安. All rights reserved.
//

import UIKit
import Moya
import WebKit

class ViewController: UIViewController {
    
    let viewModel: ViewControllerViewModel = ViewControllerViewModel()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
        viewModel.prepareRequest()
    }

    func bindViewModel() {
        viewModel.onRequestEnd = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listCellViewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserListCell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! UserListCell
        let listCellViewModel = viewModel.listCellViewModels[indexPath.row]
        cell.setup(viewModel: listCellViewModel)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let listCellViewModel = viewModel.listCellViewModels[indexPath.row]
        guard let login = listCellViewModel.login else {
            return
        }
        let detailPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailPage.viewModel.login = login
        self.present(detailPage, animated: true, completion: nil)
        
        
    }
    
}

