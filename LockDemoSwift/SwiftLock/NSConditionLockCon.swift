//
//  NSConditionLockCon.swift
//  LockDemoSwift
//
//  Created by 岳琛 on 2019/10/24.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

import UIKit

class NSConditionLockCon: ThreadLockController {
    
    var imageMutableArray:Array<Any> = Array.init()
    let lock = NSConditionLock.init()
    
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
         条件锁 NSConditionLock
         通过 NSCondition 来实现，内部持有一个 condition 
         加解锁过程与 NSLock 几乎一致
         */
    }
        
    // MARK: - startTestBtnAction
    override func removeFromDataImageArray() {

        while true {
            lock.lock()
            
            if imageMutableArray.count > 0 {
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
