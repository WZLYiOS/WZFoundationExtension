//
//  Timer+.swift
//  WZFoundationExtension
//
//  Created by qiuqixiang on 2021/2/2.
//

import Foundation
import WZNamespaceWrappable

// MARK: - 扩展定时器
public extension WZNamespaceWrapper where WrappedType: Timer {
    
    static func scheduledTimer(timeInterval ti: TimeInterval, target aTarget: NSObjectProtocol, selector aSelector: Selector, userInfo aInfo: Any?, repeats yesOrNo: Bool) -> Timer {
        
        let proxy = TimerProxy.init(target: aTarget, sel: aSelector)
        let timer = Timer.scheduledTimer(timeInterval: ti, target: proxy, selector: aSelector, userInfo:aInfo, repeats: yesOrNo)
        proxy.timer = timer
        return timer
    }
}


/// MARK - 处理Timer强引用类
public class TimerProxy: NSObject {
    
    weak var target:  NSObjectProtocol?
    var sel: Selector?
    
    /// required，实例化timer之后需要将timer赋值给proxy，否则就算target释放了，timer本身依然会继续运行
    public weak var timer:  Timer?
    
    public required init(target: NSObjectProtocol?, sel: Selector?) {
        
        self.target = target
        self.sel = sel
        super.init()
        
        // 加强安全保护
        guard target?.responds(to: sel) == true else {
            return
        }
        // 将target的selector替换为redirectionMethod，该方法会重新处理事件
        let method = class_getInstanceMethod(self.classForCoder, #selector(TimerProxy.redirectionMethod))!
        class_replaceMethod(self.classForCoder, sel!, method_getImplementation(method), method_getTypeEncoding(method))
    }
    
    @objc func redirectionMethod () {
        // 如果target未被释放，则调用target方法，否则释放timer
        if self.target != nil {
            self.target!.perform(self.sel)
        } else {
            self.timer?.invalidate()
        }
    }
}
