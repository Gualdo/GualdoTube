//
//  RootPageViewController.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import UIKit

enum ScrollDirection {
    case goingLeft
    case goingRight
}

protocol RootPageProtocol: AnyObject {
    func currentPage(_ index: Int)
    func scrollDetails(direction: ScrollDirection, percent: CGFloat, index: Int)
}

class RootPageViewController: UIPageViewController {
    
    weak var rootDelegate: RootPageProtocol?
    
    var subViewControllers = [UIViewController]()
    var currentIndex: Int = 0
    var startOffset: CGFloat = 0
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        rootDelegate?.currentPage(0)
        setupControllers()
        setScrollViewDelegate()
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
    
    private func setScrollViewDelegate() {
        guard let scrollView = view.subviews.filter({ $0 is UIScrollView }).first as? UIScrollView else { return }
        scrollView.delegate = self
    }
}

extension RootPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let index = pageViewController.viewControllers?.first?.view.tag {
            currentIndex = index
            rootDelegate?.currentPage(index)
        }
    }
}

extension RootPageViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
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
}

extension RootPageViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var direction = 0 // Scroll stopped
        
        if startOffset < scrollView.contentOffset.x {
            direction = 1 // Right
        } else if startOffset > scrollView.contentOffset.x {
            direction = -1 // Left
        }
        
        let positionFromStartOfCurrentPage = abs(startOffset - scrollView.contentOffset.x)
        let percent = positionFromStartOfCurrentPage / self.view.frame.width
        
        rootDelegate?.scrollDetails(direction: direction == 1 ? .goingRight : .goingLeft, percent: percent, index: currentPage)
    }
}
