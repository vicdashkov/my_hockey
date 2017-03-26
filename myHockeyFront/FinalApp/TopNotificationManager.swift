//
//  TopNotificationManager.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-07-02.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import Foundation
import UIKit

class TopNotificationManager {
    
    // MARK: Instance Variables
    
    fileprivate static let mainWindow = Constants.MAIN_WINDOW!
    
//    private static var messagesQueue = [String]()
    
    fileprivate static let myLabel = UILabel(frame: CGRect(x: 0, y: 17, width: 250, height: 20))
    
    fileprivate static let screenWidth = UIScreen.main.bounds.width
    
    // MARK: Public Methods
    
    static func addMessageToFlash(_ text: String) {
        
//        messagesQueue += [text]
        
        doAnimation(text)
    }
    
    // MARK: Private Methods
    
    fileprivate static func doAnimation(_ message: String) {
//        if messagesQueue.count > 0 {
        
//            let text = messagesQueue.removeAtIndex(0)
        
            myLabel.center.x = screenWidth + (125)
            
            myLabel.text = message
            myLabel.textColor = UIColor.white
            myLabel.textAlignment = NSTextAlignment.center
            myLabel.backgroundColor = UIColor.blue
            myLabel.layer.cornerRadius = 8.0
            myLabel.clipsToBounds = true
            
            mainWindow.addSubview(myLabel)
            
            animateLabelBlock()
//        }
    }
    
    fileprivate static func animateLabelBlock() {
//        dispatch_async(dispatch_get_main_queue(),{
        
            UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions(), animations: {
                myLabel.center.x -= 125 + screenWidth / 2
                }, completion: { someBool in
//                    dispatch_async(dispatch_get_main_queue(),{
                        UIView.animate(withDuration: 2, delay: 2, options: UIViewAnimationOptions(), animations: {
                            myLabel.center.x -= screenWidth
                            }, completion: { complete in
                                purgeLabel()
                            })
//                    })
            })
//        })
        
//                })
    }
    
    fileprivate static func purgeLabel() {
        myLabel.removeFromSuperview()
    }
    
    
}
