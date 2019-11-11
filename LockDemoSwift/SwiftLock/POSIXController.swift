//
//  POSIXController.swift
//  LockDemoSwift
//
//  Created by 岳琛 on 2019/10/24.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

import UIKit

class POSIXController: ThreadLockController {

    var imageMutableArray: Array<Any> = Array.init()
        
    //初始化pthread_mutex_t类型变量
    var mutex: pthread_mutex_t = pthread_mutex_t()
    
    deinit {
        pthread_mutex_destroy(&mutex);  //释放该锁的数据结构
        TYLog()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化
        pthread_mutex_init(&mutex,nil)
        
        for  i in 0...2222 {
            imageMutableArray.append("imageArray==="+String(i))
        }
        
        TYLog("你初始化的数组个数是:\(imageMutableArray.count)")
        
        /**
         互斥锁
         实现原理与信号量非常相似 性能略低于信号量
         一个线程只能申请一次锁，也只能在获得锁的情况下才能释放锁，多次申请锁或释放未获得的锁都会致崩溃。
         假设在已经获得锁的情况下再次申请锁，线程会因为等待锁的释放而进入睡眠状态，因此就不可能再释放锁，从而导致死锁。
         */
    }
        
    // MARK: - startTestBtnAction
    
    override func removeFromDataImageArray() {
        
        while true {
            // 加锁
            // 跨平台的线程API 不同平台的底层实现可能不同 有时内部实现可能是基于信号量
            pthread_mutex_lock(&mutex)
            
            if imageMutableArray.count > 0 {
                imageMutableArray.removeLast()
            } else {
                now = CFAbsoluteTimeGetCurrent()
                let resultString = "操作开始时间:" + String(describing: then!) + "\n结束时间:" + String(describing: now!) + "\n整个操作用时:" + String(now! - then!) + "ms"
                DispatchQueue.main.async {
                    TYLog(resultString)
                    self.resulttextView.text = resultString
                }
                // 解锁
                pthread_mutex_unlock(&mutex);
                return
            }
            // 解锁
            pthread_mutex_unlock(&mutex)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
}
