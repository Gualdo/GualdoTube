//
//  MainViewController.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import UIKit

class MainViewController: UIViewController {
    
    var rootPageViewController: RootPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RootPageViewController {
            destination.rootDelegate = self
            rootPageViewController = destination
        }
    }
}

extension MainViewController: RootPageProtocol {
    func currentPage(_ index: Int) {
        print("Current page: ", index)
    }
}
