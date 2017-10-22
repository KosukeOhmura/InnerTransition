//
//  UIView+.swift
//  Demo
//
//  Created by Ohmura Kosuke on 2017/10/22.
//  Copyright © 2017年 KosukeOhmura. All rights reserved.
//

import Foundation
import UIKit

public protocol Transitionable: class {}

extension UIView: Transitionable {}

public extension Transitionable where Self: UIView {
    
    // MARK: transit methods
    
    public func fade(duration: CFTimeInterval? = nil, transitions: (Self) -> Void, completion: ((Bool) -> Void)? = nil) {
        transit(type: .fade, withDuration: duration, transitions: transitions, completion: completion)
    }
    
    public func moveIn(from: InnerTransition.From, duration: CFTimeInterval? = nil, transitions: (Self) -> Void, completion: ((Bool) -> Void)? = nil) {
        transit(type: .moveIn(from: from), withDuration: duration, transitions: transitions, completion: completion)
    }
    
    public func push(from: InnerTransition.From, duration: CFTimeInterval? = nil, transitions: (Self) -> Void, completion: ((Bool) -> Void)? = nil) {
        transit(type: .push(from: from), withDuration: duration, transitions: transitions, completion: completion)
    }
    
    public func reveal(from: InnerTransition.From, duration: CFTimeInterval? = nil, transitions: (Self) -> Void, completion: ((Bool) -> Void)? = nil) {
        transit(type: .reveal(from: from), withDuration: duration, transitions: transitions, completion: completion)
    }
    
    private func transit(type transitionType: InnerTransition.TransitionType, withDuration duration: CFTimeInterval? = nil, transitions: (Self) -> Void, completion: ((Bool) -> Void)? = nil) {
        
        let transition = CATransition()
        (transition.type, transition.subtype) = transitionType.kCAValuePair
        
        if let duration = duration {
            transition.duration = duration
        }
        
        if let completion = completion {
            transition.delegate = CompletionHolder(completion: completion)
        }
        
        layer.add(transition, forKey: kCATransition)
        
        transitions(self)
    }
    
}

// MARK: CompletionHolder

private final class CompletionHolder: NSObject {
    
    let completion: (Bool) -> Void
    
    init(completion: @escaping (Bool) -> Void) {
        self.completion = completion
    }
    
}

extension CompletionHolder: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        completion(flag)
    }
    
}
