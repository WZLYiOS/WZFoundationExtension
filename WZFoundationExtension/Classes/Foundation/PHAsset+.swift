//
//  PHAsset+.swift
//  Created on 2021/12/31
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2021 WZLY. All rights reserved.
//  @author 邱啟祥(739140860@qq.com)   
//

import Foundation
import WZNamespaceWrappable
import Photos


// MARK - 资源
private var imageAssetPathKey: Void?
extension WZNamespaceWrappable where Base == PHAsset {
    

    func getURL(completionHandler : @escaping ((_ responseURL : URL?) -> Void)){
            if base.mediaType == .image {
                let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
                options.canHandleAdjustmentData = {(adjustMeta: PHAdjustmentData) -> Bool in
                    return true
                }
                base.requestContentEditingInput(with: options,completionHandler: {(contentEditingInput: PHContentEditingInput?,info: [AnyHashable : Any]) -> Void in
                    completionHandler(contentEditingInput?.fullSizeImageURL as URL?)
                })
            } else if base.mediaType == .video {
                let options: PHVideoRequestOptions = PHVideoRequestOptions()
                options.version = .original
                PHImageManager.default().requestAVAsset(forVideo: base,options: options,resultHandler: {(asset: AVAsset?,audioMix: AVAudioMix?,info: [AnyHashable : Any]?) -> Void in
                    if let urlAsset = asset as? AVURLAsset {
                        let localVideoUrl: URL = urlAsset.url as URL
                        completionHandler(localVideoUrl)
                    } else {
                        completionHandler(nil)
                    }
                })
            }
        }
}

