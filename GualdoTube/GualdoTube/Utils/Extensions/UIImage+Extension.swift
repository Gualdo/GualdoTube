//
//  UIImage+Extension.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 29/5/23.
//

import UIKit

extension UIImage {
    
    @nonobjc class var bellIcon: UIImage? {
        return UIImage(named: "bell")
    }
    
    @nonobjc class var dotsIcon: UIImage? {
        return UIImage(named: "dots")
    }
    
    @nonobjc class var magnifyingIcon: UIImage? {
        return UIImage(named: "magnifying")
    }
    
    @nonobjc class var castIcon: UIImage? {
        return UIImage(named: "cast")
    }
    
    @nonobjc class var chevronRightIcon: UIImage? {
        return UIImage(systemName: "chevron.right")
    }
    
    @nonobjc class var textAlignLeftIcon: UIImage? {
        return UIImage(systemName: "text.alignleft")
    }
}
