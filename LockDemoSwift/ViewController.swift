//
//  ViewController.swift
//  LockDemoSwift
//
//  Created by 岳琛 on 2019/10/24.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         @synchronized、
         NSConditionLock、
         NSRecursiveLock、
         NSCondition、
         NSLock、
         pthread_mutex、
         dispatch_semaphore、
         OSSpinLock
         */
    }

    @IBAction func touchAction(_ sender: UIButton) {
        
        // 我们使用多个线程去删除一个数组里面的东西，这样就有一个资源竞争的问题
        switch sender.tag {
        case 1:
            let vc = SynchronizedController()
            self.present(vc, animated: true, completion: nil)
        case 2:
            let vc = SemaphoreController()
            self.present(vc, animated: true, completion: nil)
        case 3:
            let vc = POSIXController()
            self.present(vc, animated: true, completion: nil)
        case 4:
            let vc = NSRecursiveLockCon()
            self.present(vc, animated: true, completion: nil)
        case 5:
            let vc = NSLockController()
            self.present(vc, animated: true, completion: nil)
        case 6:
            let vc = NSConditionLockCon()
            self.present(vc, animated: true, completion: nil)
        case 7:
            let vc = NSConditionController()
            self.present(vc, animated: true, completion: nil)
        default:
            break
        }
    }
    
    
}

