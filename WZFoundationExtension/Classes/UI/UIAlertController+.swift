//
//  UIAlertController+.swift
//  WZUIExtension
//
//  Created by xiaobin liu on 2020/8/12.
//  Copyright © 2020 我主良缘. All rights reserved.
//

import UIKit

/// MARK - UIAlertController +
public extension NamespaceWrappable where Base: UIAlertController {
    
    
    /// 提示框(取消就是传-1)
    /// - Parameter vc: 显示警报的视图控制器
    /// - Parameter title: 标题
    /// - Parameter message: 消息
    /// - Parameter attributedMessage: 富文本消息
    /// - Parameter textAlignment: 文本对其方式
    /// - Parameter preferredStyle: 弹出样式
    /// - Parameter cancelAction: 取消事件
    /// - Parameter actions: 其他事件
    /// - Parameter tintColor: tintColor
    /// - Parameter handler: handler description
    static func show<Action: CustomStringConvertible>(in vc: UIViewController? = nil,
                                                      title: String? = nil,
                                                      message: String? = nil,
                                                      attributedMessage: NSAttributedString? = nil,
                                                      textAlignment: NSTextAlignment = .center,
                                                      preferredStyle: UIAlertController.Style = .alert,
                                                      cancelAction: Action? = nil,
                                                      actions: [Action]? = nil,
                                                      tintColor: UIColor? = nil,
                                                      handler: ((_ action: Action, _ index: Int) -> Void)? = nil) {
        
        guard let controller = vc == nil ? UIViewController.topMostController:vc else { return }
        let alertView = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertView.wz.show(in: controller,
                          attributedMessage: attributedMessage,
                          textAlignment: textAlignment,
                          preferredStyle: preferredStyle,
                          cancelAction: cancelAction,
                          actions: actions,
                          tintColor: tintColor, handler: handler)
    }
    
    
    /// 提示框(取消就是传-1)
    /// - Parameter vc: 显示警报的视图控制器
    /// - Parameter attributedMessage: 富文本消息
    /// - Parameter textAlignment: 文本对其方式
    /// - Parameter preferredStyle: 弹出样式
    /// - Parameter cancelAction: 取消事件
    /// - Parameter actions: 其他事件
    /// - Parameter tintColor: tintColor
    /// - Parameter handler: handler description
    private func show<Action : CustomStringConvertible>(in vc: UIViewController,
                                                        attributedMessage: NSAttributedString? = nil,
                                                        textAlignment: NSTextAlignment = .center,
                                                        preferredStyle: UIAlertController.Style = .alert,
                                                        cancelAction: Action? = nil,
                                                        actions: [Action]? = nil,
                                                        tintColor: UIColor? = nil,
                                                        handler: ((_ action: Action, _ index: Int) -> Void)? = nil) {
        
        let alertView = self.base
        
        if let temAttributedMessage = attributedMessage {
            /// 设置自定义Message的NSAttributedString (attributedTitle)
            alertView.setValue(temAttributedMessage, forKey: "attributedMessage")
        }
        
        if let temCancel = cancelAction {
            alertView.addAction(UIAlertAction(title: temCancel.description, style: UIAlertAction.Style.cancel, handler: { _ in
                handler?(temCancel, -1)
            }))
        }
        
        if let temAction = actions {
            
            for (index, action) in temAction.enumerated() {
                alertView.addAction(UIAlertAction(title: action.description, style: .default) { _ in
                    handler?(action, index)
                })
            }
        }
        
        /// 设置文本对其方式
        if let message = alertView.view.subviews[0]
            .subviews[0]
            .subviews[0]
            .subviews[0]
            .subviews[0]
            .subviews[1] as? UILabel {
            message.textAlignment = textAlignment
        }
        
        /// 设置关闭按钮或者其他的按钮的颜色
        if let color = tintColor {
            alertView.view.tintColor = color
        }
        DispatchQueue.main.async {
            vc.present(self.base, animated: true, completion: nil)
        }
    }
}

// MARK: - Methods
@objc public extension UIViewController {
    
    /// 返回当前应用程序的最顶层视图控制器。
    @objc class var topMostController: UIViewController? {
        guard let currentWindows = UIApplication.shared.windows.first(where: {$0.isKeyWindow}),
                let rootViewController = currentWindows.rootViewController else { return nil }
        return self.wzTopMost(of: rootViewController)
    }
    
    
    /// 返回给定视图控制器堆栈中最顶层的视图控制器
    ///
    /// - Parameter viewController: viewController description
    /// - Returns: return value description
    @objc private class func wzTopMost(of viewController: UIViewController?) -> UIViewController? {
        
        // presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return self.wzTopMost(of: presentedViewController)
        }
        
        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.wzTopMost(of: selectedViewController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.wzTopMost(of: visibleViewController)
        }
        
        // UIPageController
        if let pageViewController = viewController as? UIPageViewController,
            pageViewController.viewControllers?.count == 1 {
            return self.wzTopMost(of: pageViewController.viewControllers?.first)
        }
        
        // child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.wzTopMost(of: childViewController)
            }
        }
        return viewController
    }
}
