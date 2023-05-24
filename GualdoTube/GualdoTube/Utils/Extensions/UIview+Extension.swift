//
//  UIview+Extension.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 25/5/23.
//

import UIKit

extension UIView {
    
    func animateBottomSheet(show: Bool, onCompleted: (() -> Void)? = nil) {
        if show {
            self.frame.origin.y += self.frame.height
            UIView.animate(
                withDuration: 0.2,
                delay: 0.0,
                options: .curveEaseIn
            ) {
                self.frame.origin.y -= self.frame.height
            } completion: { _ in
                onCompleted?()
            }
        } else {
            UIView.animate(
                withDuration: 0.2,
                delay: 0.0,
                options: .curveEaseIn
            ) {
                self.frame.origin.y += self.frame.height + 50
                self.animateOverlay {
                    onCompleted?()
                }
            }
        }
    }
    
    func animateOverlay(delay: TimeInterval = 0.0, onComplete: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.7,
            delay: delay,
            options: .curveEaseIn) {
                self.alpha = 0
            } completion: { _ in
                onComplete?()
            }
    }
}
