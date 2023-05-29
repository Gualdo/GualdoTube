//
//  UITableView+Extension.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 29/5/23.
//

import UIKit

extension UITableView {
    
    public func registerFromNib<T: UITableViewCell>(cellClass: T.Type) {
        register(UINib(nibName: "\(cellClass.self)", bundle: nil), forCellReuseIdentifier: "\(cellClass.self)")
    }
    
    public func registerFromNib<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) {
        register(UINib(nibName: "\(headerFooterView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: "\(headerFooterView.self)")
    }
    
    public func registerFromClass<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass.self, forCellReuseIdentifier: "\(cellClass.self)")
    }
    
    public func registerFromClass<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) {
        register(headerFooterView.self, forHeaderFooterViewReuseIdentifier: "\(headerFooterView.self)")
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for cell: T.Type, in indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: "\(cell.self)", for: indexPath) as? T
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for cell: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: "\(cell.self)") as? T
    }
}
