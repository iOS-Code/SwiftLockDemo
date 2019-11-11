//
//  NSRecursiveLockCon.swift
//  LockDemoSwift
//
//  Created by 岳琛 on 2019/10/24.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

import UIKit


class NSRecursiveLockCon: ThreadLockController {
    
    var imageMutableArray:Array<Any> = Array.init()
    
    // 队列标识String
    private let queueLabel = "queueLabel"
    let recursiveLock = NSRecursiveLock()
    
    deinit {
        TYLog()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for  i in 0...2222 {
            imageMutableArray.append("imageArray==="+String(i))
        }
        
        TYLog("你初始化的数组个数是:\(imageMutableArray.count)")
        
        /**
         递归锁 NSRecursiveLock, pthread_mutex(recursive) 的封装
         
         pthread_mutex(recursive) 互斥锁的一种，属于递归锁
         一般一个线程只能申请一把锁，但如果是递归锁，则可以申请很多把锁，只要上锁和解锁的操作数量就不会报错。
         
         与 NSLock 类似，通过 pthread_mutex_lock 实现，但是内部封装的 pthread_mutex_t 的类型不同 PTHREAD_MUTEX_RECURSIVE
         */
    }
    
    // 递归调用
    func removeFromImageArray() {
        
        recursiveLock.lock()
        
        if (imageMutableArray.count > 0) {
            imageMutableArray.removeLast()
            self.removeFromImageArray()
        }
        
        recursiveLock.unlock()
    }
    
    // MARK: - removeFromDataImageArray
    // 模仿递归调用
    override func removeFromDataImageArray() {
        
        let dispatchGroup  = DispatchGroup.init()
        let dispatchQueue  = DispatchQueue.init(label:queueLabel, qos: .default, attributes: .concurrent)
        dispatchQueue.async(group: dispatchGroup, qos: .default, flags: DispatchWorkItemFlags.noQoS) {
            self.removeFromImageArray()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.now = CFAbsoluteTimeGetCurrent()
            
            let resultString = "操作开始时间:" + String(describing: self.then!) + "\n结束时间:" + String(describing: self.now!) + "\n整个操作用时:" + String(self.now! - self.then!) + "ms"
            
            TYLog(resultString)
            self.resulttextView.text = resultString
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
