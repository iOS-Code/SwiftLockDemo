//
//  SemaphoreController.swift
//  LockDemoSwift
//
//  Created by 岳琛 on 2019/10/24.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

import UIKit

class SemaphoreController: ThreadLockController {
    
    var imageMutableArray: Array<Any> = Array.init()
    
    // 直接在这里初始化一个信号量
    let semaPhore = DispatchSemaphore.init(value: 1)
    
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
         信号量
         semaPhore.wait()
         发等待信号，信号量就-1，变成0，后面的任务就会处于等待状态
         等到信号量大于等于1的时候在执行,要是信号量不大于或者等于你初始化时候的值，它就一直处于等待状态
         
         semaPhore.wait(timeout: DispatchTime.init(uptimeNanoseconds: UInt64(10)))
         设置等待的时间
         但过了这个时间之后在进入就等于是我们的锁失效了。面临的问题也就是相应的崩溃
        */
    }
        
     // MARK: - startTestBtnAction
     override func removeFromDataImageArray() {
        while true {
            
            _ = semaPhore.wait(timeout: DispatchTime.distantFuture)
            
            if imageMutableArray.count > 0 {
                imageMutableArray.removeLast()
            } else {
                now = CFAbsoluteTimeGetCurrent()
                let resultString = "操作开始时间:" + String(describing: then!) + "\n结束时间:" + String(describing: now!) + "\n整个操作用时:" + String(now! - then!) + "ms"
                DispatchQueue.main.async {
                    TYLog(resultString)
                    self.resulttextView.text = resultString
                }

                // signal() 方法，这里会使信号量+1
                semaPhore.signal()
                return
            }
            
            // signal() 方法，这里会使信号量+1
            semaPhore.signal()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
