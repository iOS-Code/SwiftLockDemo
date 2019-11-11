//
//  ThreadLockController.swift
//  LockDemoSwift
//
//  Created by 岳琛 on 2019/10/24.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

import UIKit

class ThreadLockController: UIViewController {
    
    // 用这两个数值记录操作的开始和结束时间
    var then:Double?
    var now :Double?
    
    // MARK: - lazyControls
    lazy var startTestBtn: UIButton = {
        let startTestBtn = UIButton.init(type: UIButton.ButtonType.custom)
        startTestBtn.addTarget(self, action: #selector(startTestBtnAction), for: .touchUpInside)
        startTestBtn.setTitle("开始测试", for: .normal)
        startTestBtn.setTitleColor(UIColor.black, for: .normal)
        return startTestBtn
    }()
    
    lazy var resulttextView: UITextView = {
        let resultTextView = UITextView.init(frame: CGRect.zero)
        resultTextView.layer.borderColor = UIColor.black.cgColor
        resultTextView.layer.borderWidth = 1
        return resultTextView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubview()
    }
    
    // MARK: - config
    func configSubview() -> Void {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.startTestBtn)
        startTestBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 50)
        startTestBtn.center = self.view.center
        
        self.view.addSubview(self.resulttextView)
        resulttextView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.8, height: 100)
        let center = startTestBtn.center
        resulttextView.center = CGPoint(x: center.x, y: center.y + 200)
    }
    
    // MARK: - removeFromDataImageArray
    func removeFromDataImageArray() {
        TYLog(CFAbsoluteTimeGetCurrent())
    }
    
    // MARK: - startTestBtnAction
    @objc func startTestBtnAction() {
        // 我们使用多个线程去删除一个数组里面的东西，这样就有一个资源竞争的问题，我们看看
        TYLog()
        
        then = CFAbsoluteTimeGetCurrent()
        for _ in 0...9999 {
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 0.05) {
                // 全局同步队列里面的异步线程操作数组
                self.removeFromDataImageArray()
            }
//            DispatchQueue.global().async { }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
