//
//  NSMutableAttributedString+.swift
//  WZFoundationExtension
//
//  Created by qiuqixiang on 2021/2/2.
//

import Foundation
import WZNamespaceWrappable

/// MARK -  NSMutableAttributedString扩展
public extension WZNamespaceWrapper where WrappedType: NSMutableAttributedString {
    
    
    func convenientSet( font: UIFont, textColor: UIColor, backColor: UIColor = UIColor.clear, lineSpace: CGFloat = 5, range: NSRange = NSRange(location: 0, length: 0)) {
        let useRange = range.length == 0 ? NSRange(location: 0, length: wrappedValue.length) : range
        setFont(font: font, range: useRange)
        setTextColor(color: textColor, range: useRange)
        setBackColor(color: backColor, range: useRange)
        setLineSpace(lineSpace, range: useRange)
    }
    
    /// 设置字体
    func setFont(font: UIFont, range: NSRange? = nil) {
        setAttribute(name: NSAttributedString.Key.font, value: font, range: range ?? NSRange(location: 0, length: wrappedValue.length))
    }
    
    /// 设置文字颜色
    func setTextColor(color: UIColor, range: NSRange? = nil) {
        setAttribute(name: NSAttributedString.Key.foregroundColor, value: color, range: range ?? NSRange(location: 0, length: wrappedValue.length))
    }
    
    /// 设置文字背景色
    func setBackColor(color: UIColor, range: NSRange? = nil) {
        setAttribute(name: NSAttributedString.Key.backgroundColor, value: color, range: range ?? NSRange(location: 0, length: wrappedValue.length))
    }
    
    /// 设置下划线样式
    func setUnderLineStyle(lineStyle: NSUnderlineStyle, range: NSRange? = nil) {
        setAttribute(name: NSAttributedString.Key.underlineStyle, value: lineStyle, range: range ?? NSRange(location: 0, length: wrappedValue.length))
    }
    
    /// 设置行间距
    func setLineSpace(_ lineSpace: CGFloat, range: NSRange? = nil){
        let mPara = NSMutableParagraphStyle()
        mPara.lineSpacing = lineSpace;
        setAttribute(name: NSAttributedString.Key.paragraphStyle, value: mPara, range: range ?? NSRange(location: 0, length: wrappedValue.length))
    }
    
    /// 设置属性
    func setAttribute(name: NSAttributedString.Key, value: Any, range: NSRange? = nil) {
        if name.rawValue.count==0 {
            return
        }
        wrappedValue.addAttribute(name, value: value, range: range ?? NSRange(location: 0, length: wrappedValue.length))
    }
    
    /// 计算富文本高度
    func getContentHeight(with: CGFloat, maxHeight: CGFloat = CGFloat(MAXFLOAT) ) -> CGFloat {
        
        let frame = wrappedValue.boundingRect(with: CGSize(width: with, height: maxHeight), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue), context: nil)
        return frame.size.height
    }
    
    /// 富文本添加图片
    func appendImageAttachment(image: UIImage?) {
        let attch = NSTextAttachment()
        attch.bounds = CGRect(x: 0, y: 0, width: image?.size.width ?? 0, height: image?.size.height ?? 0)
        attch.image = image
        let attachment = NSAttributedString(attachment: attch)
        self.wrappedValue.append(attachment)
    }
    
    /// 塞入富文本
    func insertImageAttachment(image: UIImage?, at: Int) {
        let attch = NSTextAttachment()
        attch.bounds = CGRect(x: 0, y: 0, width: image?.size.width ?? 0, height: image?.size.height ?? 0)
        attch.image = image
        let attachment = NSAttributedString(attachment: attch)
        self.wrappedValue.insert(attachment, at: at)
    }
    
    /// 获取字符出现的位置信息(支持多次位置获取)
    /// - Parameter string: 原始文本
    /// - Parameter inString: 需要查找的字符
    func rangeOfString(inString: String) -> [NSRange] {
        
        var arrRange = [NSRange]()
        let string = wrappedValue.string as NSString
        var _fullText: NSString = string
        var rang:NSRange = _fullText.range(of: inString)
        
        while rang.location != NSNotFound {
            var location:Int = 0
            if arrRange.count > 0 {
                if arrRange.last!.location + arrRange.last!.length < string.length {
                     location = arrRange.last!.location + arrRange.last!.length
                }
            }
            _fullText = NSString.init(string: _fullText.substring(from: rang.location + rang.length))
 
            if arrRange.count > 0 {
                  rang.location += location
            }
            arrRange.append(rang)
            
            rang = _fullText.range(of: inString)
        }
        
        return arrRange
    }
    
    /// 检查数组
    func range(_ of: String) -> NSRange {
        return (wrappedValue.string as NSString).range(of: of)
    }
}

