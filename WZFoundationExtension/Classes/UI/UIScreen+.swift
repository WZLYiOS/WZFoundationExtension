//
//  UIScreen+.swift
//  Created on 2023/11/7
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2023 WZLY. All rights reserved.
//  @author 邱啟祥(739140860@qq.com)   
//

import Foundation
import WZNamespaceWrappable

// 一些配置
public extension WZNamespaceWrappable where Base: UIScreen {
    
    /// 安全区域底部
    static var safeAreaInsetsBottom: CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }
    
    /// 状态栏高度
    static var statusHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.statusBarFrame.height
        } else {
            return 24
        }
    }
    
    /// 屏幕宽度
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /// 屏幕高度
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    
    /// 获取一像素的大小
    static var pixelOne: CGFloat {
        return 1/UIScreen.main.scale
    }
    
    /// tabbar 高度
    static var tabbarHeight: CGFloat {
        return 49+safeAreaInsetsBottom
    }
    
    /// 导航栏高度
    static var navigationHeight: CGFloat {
        return 44+statusHeight
    }
}
