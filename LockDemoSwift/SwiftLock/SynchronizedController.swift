//
//  SynchronizedController.swift
//  LockDemoSwift
//
//  Created by 岳琛 on 2019/10/24.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

import UIKit

class SynchronizedController: ThreadLockController {
    
    var imageMutableArray: Array<Any> = Array.init()
    
    deinit {
        TYLog()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for i in 0...2222 {
            imageMutableArray.append("imageArray")
        }
        
        TYLog("你初始化的数组个数是:\(imageMutableArray.count)")
        
        
        /**
         OC锁
         OC层面提供的系统锁，需要使用OC对象来当做锁的标识
         底层通过哈希表来实现，加入了一个互斥锁的数组，通过对对象取哈希值来得到对应的互斥锁
         
         @synchronized(obj)指令使用的obj为该锁的唯一标识,只有当标识相同时，才为满足互斥
         @synchronized指令实现锁的优点就是我们不需要在代码中显式的创建锁对象，便可以实现锁的机制
         @synchronized块会隐式的添加一个异常处理例程来保护代码，该处理例程会在异常抛出的时候自动的释放互斥锁
         所以如果不想让隐式的异常处理例程带来额外的开销，你可以考虑使用锁对象
         */
    }
    
    // MARK: - removeFromDataImageArray
    override func removeFromDataImageArray() {
        
        while true {
            objc_sync_enter(self)
            
            if imageMutableArray.count > 0 {
                imageMutableArray.removeLast()
            } else {
                now = CFAbsoluteTimeGetCurrent()
                let resultString = "操作开始时间:" + String(describing: then!) + "\n结束时间:" + String(describing: now!) + "\n整个操作用时:" + String(now! - then!) + "ms"
                
                DispatchQueue.main.async {
                    TYLog(resultString)
                    self.resulttextView.text = resultString
                }
                
                objc_sync_exit(self)
                return
            }

            objc_sync_exit(self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
