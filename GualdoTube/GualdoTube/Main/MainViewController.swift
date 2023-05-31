//
//  MainViewController.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var tabsView: TabsView!
    
    private let options: [String] = ["HOME", "VIDEOS", "PLAYLIST", "CHANNEL", "ABOUT"]
    
    var rootPageViewController: RootPageViewController!
    var currentPageindex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        tabsView.buildView(delegate: self, options: options)
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

extension MainViewController: TabsViewProtocol {
    
    func didSelectOption(index: Int) {
        if index != currentPageindex {
            var direction: UIPageViewController.NavigationDirection = .forward
            
            if index < currentPageindex {
                direction = .reverse
            }
            
            rootPageViewController.setViewControllerFromIndex(index: index, direction: direction)
            currentPageindex = index
        }
    }
}
