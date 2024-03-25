//
//  UIImage+.swift
//  WZUIExtension
//
//  Created by xiaobin liu on 2020/8/12.
//  Copyright © 2020 我主良缘. All rights reserved.
//

import UIKit

// MARK: - 扩展
public extension NamespaceWrappable where Base: UIImage {
    
    /// UIImage字节大小
    var bytesSize: Int {
        return base.jpegData(compressionQuality: 1)?.count ?? 0
    }
    
    /// UIImage1024字节大小
    var kilobytesSize: Int {
        return bytesSize / 1024
    }
    
    /// UIImage与alwaysoriginal渲染模式。
    var original: UIImage {
        return base.withRenderingMode(.alwaysOriginal)
    }
    
    /// UIImage与alwaystemplate渲染模式。
    var template: UIImage {
        return base.withRenderingMode(.alwaysTemplate)
    }
    
    /// 九宫格拉伸
    var resizable: UIImage {
        let widthFloat = floor(base.size.width/2)
        let heightFloat = floor(base.size.height/2)
        return base.resizableImage(withCapInsets: UIEdgeInsets(top: heightFloat, left: widthFloat, bottom: heightFloat, right: widthFloat))
    }
    
    /// 图片拉伸
    func resizable(edgeInsets: UIEdgeInsets, resizingMode: UIImage.ResizingMode = .stretch) -> UIImage {
        return base.resizableImage(withCapInsets: edgeInsets, resizingMode: resizingMode)
    }
    
    /// 图片缩小
    /// - Parameter reSize: reSize description
    /// - Returns: description
    func  reSizeImage(reSize: CGSize)-> UIImage  {
        UIGraphicsBeginImageContextWithOptions (reSize, false , UIScreen.main.scale)
        base.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? base
        UIGraphicsEndImageContext()
        return reSizeImage
    }
    
    /// 高斯模糊
    func blurImage(radius: CGFloat = 30) -> UIImage {
        let context = CIContext (options:  nil )
        let  inputImage = CIImage (image: base)
        //使用高斯模糊滤镜
        let  filter  =  CIFilter (name:  "CIGaussianBlur" )!
        filter.setValue(inputImage, forKey:kCIInputImageKey)
        //设置模糊半径值（越大越模糊）
        filter.setValue(radius, forKey: kCIInputRadiusKey)
        let  outputCIImage =  filter.outputImage!
        let  rect =  CGRect (origin:  CGPoint .zero, size: base.size)
        let  cgImage = context.createCGImage(outputCIImage, from: rect)
        //显示生成的模糊图片
        let newImage =  UIImage (cgImage: cgImage!)
        return newImage
    }
}


// MARK: - Initializers
public extension UIImage {
    
    // 创建图像来自颜色和大小
    //
    // - Parameters:
    //   - color: 颜色
    //   - size: 大小
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            self.init()
            return
        }
        UIGraphicsEndImageContext()
        guard let aCgImage = image.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
}

