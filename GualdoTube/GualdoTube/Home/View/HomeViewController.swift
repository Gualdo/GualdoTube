//
//  HomeViewController.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var  presenter = HomePresenter(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await presenter.getHomeObjects()
        }
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func getData(list: [[Any]]) {
        print("List: ", list)
    }
}
