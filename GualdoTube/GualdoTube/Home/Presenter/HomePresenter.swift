//
//  HomePresenter.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func getData(list: [[Any]])
}

class HomePresenter {
    
    weak var delegate: HomeViewProtocol?
    
    var provider: HomeProviderProtocol
    
    init(delegate: HomeViewProtocol, provider: HomeProviderProtocol = HomeProvider()) {
        self.delegate = delegate
        self.provider = provider
    }
    
    func getVideos() {
        
    }
}
