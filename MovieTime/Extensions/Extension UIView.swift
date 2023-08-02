//
//  Extension UIView.swift
//  MovieTime
//
//  Created by Eken Özlü on 2.08.2023.
//

import UIKit

extension UIView {
    
    func configureView(_ borderColor:UIColor,_ borderWidth:Int,
                       _ cornerRadius:Int,
                       _ shadowColor:UIColor,_ shadowOpacity:Int,_ shadowRadius:Int){
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = Float(shadowOpacity)
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = CGFloat(shadowRadius)
    }
}
