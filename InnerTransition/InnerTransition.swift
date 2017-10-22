//
//  InnerTransition.swift
//  Demo
//
//  Created by Ohmura Kosuke on 2017/10/22.
//  Copyright © 2017年 KosukeOhmura. All rights reserved.
//

import Foundation
import UIKit

public final class InnerTransition {
    
    private init() {}
    
    public enum From {
        case right
        case left
        case top
        case bottom
    }
    
    enum TransitionType {
        
        case fade
        case moveIn(from: From)
        case push(from: From)
        case reveal(from: From)
        
        var kCAValuePair: (main: String, sub: String?) {
            
            let main: String = {
                switch self {
                case .fade: return kCATransitionFade
                case .moveIn: return kCATransitionMoveIn
                case .push: return kCATransitionPush
                case .reveal: return kCATransitionReveal
                }
            }()
            
            let sub: String? = {
                switch self {
                case .fade:
                    return nil
                case .moveIn(let from), .push(let from), .reveal(let from):
                    switch from {
                    case .right: return kCATransitionFromRight
                    case .left: return kCATransitionFromLeft
                    case .top: return kCATransitionFromBottom
                    case .bottom: return kCATransitionFromTop
                    }
                }
            }()
            
            return (main, sub)
        }
        
    }
    
}
