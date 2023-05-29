//
//  UIImage+Extension.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 29/5/23.
//

import UIKit

extension UIImage {
    
    @nonobjc class var bellImage: UIImage? {
        return UIImage(named: "bell")
    }
    
    @nonobjc class var dotImage: UIImage? {
        return UIImage(named: "dots")
    }
    
    @nonobjc class var magnifyingIcon: UIImage? {
        return UIImage(named: "magnifying")
    }
    
    @nonobjc class var castImage: UIImage? {
        return UIImage(named: "cast")
    }
    
    @nonobjc class var chevronRight: UIImage? {
        return UIImage(systemName: "chevron.right")
    }
    
    @nonobjc class var textAlignLeft: UIImage? {
        return UIImage(systemName: "text.alignleft")
    }
}
