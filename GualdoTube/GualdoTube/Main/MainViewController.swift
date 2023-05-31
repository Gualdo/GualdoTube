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
    var prevPercent: CGFloat = 0
    var didTapOption: Bool = false {
        didSet {
            if didTapOption {
                tabsView.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
                    self?.didTapOption.toggle()
                    self?.tabsView.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    var currentPageIndex: Int = 0 {
        willSet {
            let cell = tabsView.collectionView.cellForItem(at: IndexPath(row: currentPageIndex, section: 0))
            cell?.isSelected = false
        }
        didSet {
            if let _ = rootPageViewController {
                rootPageViewController.currentPage = currentPageIndex
                let cell = tabsView.collectionView.cellForItem(at: IndexPath(row: currentPageIndex, section: 0))
                cell?.isSelected = true
            }
        }
    }
    
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
        currentPageIndex = index
        tabsView.selectedItem = IndexPath(row: index, section: 0)
    }
    
    func scrollDetails(direction: ScrollDirection, percent: CGFloat, index: Int) {
        guard percent != 0,
              !didTapOption,
              let currentCell = tabsView.collectionView.cellForItem(at: IndexPath(row: index, section: 0)) else { return }
        
        if let nextCell = tabsView.collectionView.cellForItem(at: IndexPath(row: index + 1, section: 0))  /* El next index sería el actual + 1*/,
           direction == .goingRight { // Right ------->>> [view]
            
            // Si se esta en la última pagina, y trata de moverse a la derecha, retorna
            if index == options.count - 1 { return }
            
            // Se suma el acumulado, mas el % scroleado de la celda actual
            let calculateNewLeading = currentCell.frame.origin.x + (currentCell.frame.width * percent)
            let newWidthPercentRight = (nextCell.frame.width - currentCell.frame.width) * percent
            let newWidthPercentLeft = (currentCell.frame.width - nextCell.frame.width) * percent
            let newWidth = prevPercent < percent ? currentCell.frame.width + newWidthPercentRight : currentCell.frame.width - newWidthPercentLeft
            
            tabsView.updateUnderline(xOrigin: calculateNewLeading, width: newWidth)
        } else if let nextCell = tabsView.collectionView.cellForItem(at: IndexPath(row: index - 1, section: 0))  /* El next index sería el actual - 1*/,
                  direction == .goingLeft { // Left [view] <<<-------
            
            // Si se esta en la primera pagina, y trata de moverse a la izquierda, retorna
            if index == 0 { return }
            
            let calculateNewLeading = currentCell.frame.origin.x - (nextCell.frame.width * percent)
            let newWidthPercentRight = (nextCell.frame.width - currentCell.frame.width) * percent
            let newWidthPercentLeft = (currentCell.frame.width - nextCell.frame.width) * percent
            let newWidth = prevPercent < percent ? currentCell.frame.width + newWidthPercentRight : currentCell.frame.width - newWidthPercentLeft
            
            tabsView.updateUnderline(xOrigin: calculateNewLeading, width: newWidth)
        }
        
        prevPercent = percent
    }
}

extension MainViewController: TabsViewProtocol {
    
    func didSelectOption(index: Int) {
        
        didTapOption = true
        
        if let currentCell = tabsView.collectionView.cellForItem(at: IndexPath(row: index, section: 0)) {
            
            tabsView.updateUnderline(xOrigin: currentCell.frame.origin.x, width: currentCell.frame.width)
            
            if index != currentPageIndex {
                var direction: UIPageViewController.NavigationDirection = .forward
                
                if index < currentPageIndex {
                    direction = .reverse
                }
                
                rootPageViewController.setViewControllerFromIndex(index: index, direction: direction)
                currentPageIndex = index
            }
        }
    }
}
