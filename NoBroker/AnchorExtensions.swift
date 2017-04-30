//
//  AnchorExtensions.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 20/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutAnchor {
    func constraintEqualToAnchor(anchor: NSLayoutAnchor!, constant:CGFloat, identifier:String) -> NSLayoutConstraint! {
        let constraint = self.constraint(equalTo: anchor, constant:constant)
        constraint.identifier = identifier
        return constraint
    }
}
extension NSLayoutDimension{
    func constraintEqualto(constant:CGFloat, identifier:String) -> NSLayoutConstraint!{
        let constraint = self.constraint(equalToConstant: constant)
        constraint.identifier = identifier
        return constraint
    }
}
extension UIView {
    func constraint(withIdentifier:String) -> NSLayoutConstraint? {
        return self.constraints.filter{ $0.identifier == withIdentifier }.first
    }
}
