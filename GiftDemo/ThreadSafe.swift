//
//  ThreadSafe.swift
//  limiGrowthSwift
//
//  Created by fyr on 29.10.20.
//  Copyright © 2020 狸米科技. All rights reserved.
//

import Foundation

import Foundation

extension DispatchQueue {
    // This method will dispatch the `block` to self.
    // If `self` is the main queue, and current thread is main thread, the block
    // will be invoked immediately instead of being dispatched.
    func safeAsync(_ block: @escaping ()->()) {
        if self === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            async { block() }
        }
    }
}
