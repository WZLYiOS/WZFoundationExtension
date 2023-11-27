//
//  UILabel+.swift
//  Pods-WZUIExtension_Example
//
//  Created by xiaobin liu on 2020/9/7.
//

import UIKit
import WZNamespaceWrappable

/// MARK - UILabel +
public extension WZNamespaceWrappable where Base: UILabel {

    /// 修复LineHeight
    static func fixLineHeightAttributed(_ lineHeight: CGFloat, font: UIFont) -> [NSAttributedString.Key: Any] {
        
        let paragrapStyle = NSMutableParagraphStyle()
        
        paragrapStyle.maximumLineHeight = lineHeight
        paragrapStyle.minimumLineHeight = lineHeight
        paragrapStyle.lineBreakMode = .byTruncatingTail
        
        let baselineOffset = fixBaseline(lineHeight: lineHeight, font: font)
        
        return [.paragraphStyle: paragrapStyle,
                .baselineOffset: baselineOffset,
                .font: font]

    }
    
    /// 根据行高和字体，生成基线值
    static func fixBaseline(lineHeight: CGFloat, font: UIFont) -> CGFloat {
        let baselineOffset = (lineHeight - font.lineHeight) / 4.0
        return baselineOffset
    }
}

// MARK - 渐变视图
open class WZGradientLabel: UILabel {

    /*
     $0.startPoint = CGPoint.init(x: 0, y: 0)
     $0.endPoint = CGPoint.init(x: 1, y: 1)
     $0.colors = [UIColor.wz.hexadecimal(rgb: 0xFF4172).cgColor,UIColor.wz.hexadecimal(rgb: 0xFD3C49).cgColor]
     $0.locations = [0.0,0.5,1.0]
     $0.cornerRadius = 0
     $0.masksToBounds = true
     */
    open class WZCAGradientLabelLayer: CAGradientLayer {
        
        public init(startPoint: CGPoint, endPoint: CGPoint, colors: [Any]?, locations: [NSNumber]?) {
            super.init()
            self.startPoint = startPoint
            self.endPoint = endPoint
            self.colors = colors
            self.locations = locations
        }
        
        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    public init(layer: WZCAGradientLabelLayer) {
        super.init(frame: CGRect.zero)
        layer.insertSublayer(layer, at: 0)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.forEach{
            ($0 as? WZCAGradientLabelLayer)?.frame = bounds
        }
    }
}
