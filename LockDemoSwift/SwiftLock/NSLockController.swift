//
//  NSLockController.swift
//  LockDemoSwift
//
//  Created by 岳琛 on 2019/10/24.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

import UIKit

class NSLockController: ThreadLockController {
    
    var imageMutableArray:Array<Any> = Array.init()
    let lock = NSLock.init()
    
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
         NSLock
         NSLock内部封装了pthread_mutex，属性为PTHREAD_MUTEX_ERRORCHECK
         */
    }
        
    // MARK: - startTestBtnAction
    override func removeFromDataImageArray() {
        
        while true {
            lock.lock()
            
            if imageMutableArray.count > 0 {
                TYLog(imageMutableArray.count)
                imageMutableArray.removeLast()
            } else {
                now = CFAbsoluteTimeGetCurrent()
                let resultString = "操作开始时间:" + String(describing: then!) + "\n结束时间:" + String(describing: now!) + "\n整个操作用时:" + String(now! - then!) + "ms"
                DispatchQueue.main.async {
                    TYLog(resultString)
                    self.resulttextView.text = resultString
                }
                lock.unlock()
                return
            }

            lock.unlock()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
