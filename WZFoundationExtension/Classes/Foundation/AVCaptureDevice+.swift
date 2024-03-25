//
//  AVCaptureDevice+.swift
//  WZFoundationExtension
//
//  Created by qiuqixiang on 2021/2/2.
//

import Foundation
import AVFoundation

// MARK - 设备授权
public extension NamespaceWrappable where Base: AVCaptureDevice {
    
    /// 视频校验权限
    static func authorizationVideoStatus(comple: ((_ granted: Bool) -> Void)?) {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                DispatchQueue.main.async {
                    comple?(granted)
                }
            }
        case .authorized:
            comple?(true)
        default:
            comple?(false)
        }
    }
    
    /// 判断是否模拟器
    static func isSimuLator() -> Bool {
        #if TARGET_IPHONE_SIMULATOR
        return true
        #else
        return false
        #endif
    }
    
    /// 打开设置
    static func openSettingsURLString(){
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
