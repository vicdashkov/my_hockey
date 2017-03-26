//
//  OddsIndicatorView.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-19.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import UIKit

class OddsIndicatorView: UIView {
    
    
    // Maximum heigh for height constraint is 94. As per cell height
    // Minimum heigh should be at least 4 to make it visible
    func animateOdds(_ odds: Double, _ heightConstraint: NSLayoutConstraint) {
        
        
//        dispatch_async(dispatch_get_main_queue(),{
        
//            print(NSThread.currentThread())

            
            self.center.y += 100
            
            heightConstraint.constant = CGFloat(4.00 + odds * 9)
            
            UIView.animate(withDuration: 0.5, animations: {
                if odds < 3 {
                    self.backgroundColor = UIColor.green
                } else if odds < 5 {
                    self.backgroundColor = UIColor.yellow
                } else {
                    self.backgroundColor = UIColor.red
                }
                self.center.y -= 100
            })
//        })
    }
    


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
