//
//  DispatchSourceTimer+.swift
//  WZLY
//
//  Created by qiuqixiang on 2021/3/22.
//  Copyright © 2021 我主良缘. All rights reserved.
//

import Foundation

/// 代理
protocol WZDispatchSourceTimerDelegate: AnyObject {
    
    /// 定时器回调
    func eventHandler(timer: WZDispatchSourceTimer)
    
    /// 时间到期自动结束
    func timeOut(timer: WZDispatchSourceTimer)
}

// MARK -  GCD 定时器
public class WZDispatchSourceTimer: NSObject {
    
    /// 代理
    weak var delegate: WZDispatchSourceTimerDelegate?
    
    /// 定时器
    var timer: DispatchSourceTimer?
    
    /// 间隔
    var interval: Int = 1
    
    /// 当前执行秒数
    var currentNum: Int = 0
    
    /// 过期时间
    var timeout: Int = 0
    
    /// 定时器是否在执行
    var isRun: Bool = false
    
    public init(interval: Int = 1) {
        super.init()
        self.interval = interval
    }
    
    deinit {
        cancel()
    }
    
    /// 定时器暂停
    func suspend() {
        isRun = false
        timer?.suspend()
    }
    
    /// 开启定时器
    func resume() {
        isRun = true
        
        if let ti = timer, ti.isCancelled == false {
            timer?.resume()
            return
        }
    
        let time = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        time.schedule(wallDeadline: .now(), repeating: Double(interval))
        time.setEventHandler(handler: { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                if self.timeout != 0 && self.timeout == self.currentNum {
                    self.cancel()
                    self.delegate?.timeOut(timer: self)
                }else{
                    self.currentNum += 1
                    self.delegate?.eventHandler(timer: self)
                }
            }
        })
        time.resume()
        timer = time
    }
    
    func cancel() {
        currentNum = 0
        isRun = false
        timer?.cancel()
        timer = nil
    }
}


