//
//  RootPageViewController.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import UIKit

protocol RootPageProtocol: AnyObject {
    func currentPage(_ index: Int)
}

class RootPageViewController: UIPageViewController {
    
    weak var rootDelegate: RootPageProtocol?
    
    var subViewControllers = [UIViewController]()
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        setupControllers()
    }
    
    private func setupControllers() {
        subViewControllers = [HomeViewController(),
                              VideosViewController(),
                              PlaylistsViewController(),
                              ChannelsViewController(),
                              AboutViewController()]
        
        _ = subViewControllers.enumerated().map{ $0.element.view.tag = $0.offset }
        
        // Esto hace lo mismo que la linea de arriba
        //        for (offset, element) in subViewControllers.enumerated() {
        //            element.view.tag = offset
        //        }
        
        setViewControllerFromIndex(index: 0, direction: .forward)
    }
    
    func setViewControllerFromIndex(index: Int, direction: NavigationDirection, animated: Bool = true) {
        setViewControllers([subViewControllers[index]], direction: direction, animated: animated)
    }
}

extension RootPageViewController: UIPageViewControllerDelegate {
    
}

extension RootPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = subViewControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return subViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = subViewControllers.firstIndex(of: viewController), index < subViewControllers.count - 1 else {
            return nil
        }
        return subViewControllers[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        print("Animation Finished: ", finished)
        if let index = pageViewController.viewControllers?.first?.view.tag {
            currentIndex = index
            rootDelegate?.currentPage(index)
        }
    }
}
