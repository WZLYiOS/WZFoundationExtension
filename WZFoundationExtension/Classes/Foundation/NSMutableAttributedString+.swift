//
//  NSMutableAttributedString+.swift
//  WZFoundationExtension
//
//  Created by qiuqixiang on 2021/2/2.
//

import Foundation
import WZNamespaceWrappable

/// MARK -  NSMutableAttributedString扩展
public extension WZNamespaceWrappable where Base: NSMutableAttributedString {
    
    /// 富文本容器
    var attributes: [NSAttributedString.Key: Any] {
        let dic = base.attributes(at: 0, effectiveRange: nil)
        return dic 
    }
    
    /// 获取当前的
    var range: NSRange {
        return NSRange(location: 0, length: base.length)
    }
    
    /// 设置字号
    var font: UIFont? {
        get {
            return attributes[NSAttributedString.Key.font] as? UIFont
        }
        set{
            setAttribute(name: NSAttributedString.Key.font, value: newValue)
        }
    }
    func setFont(font: UIFont, range: NSRange? = nil) {
        setAttribute(name: NSAttributedString.Key.font, value: font, range: range ?? base.wz.range)
    }
    
    /// 背景颜色 /// 设置文字背景色
    var backColor: UIColor? {
        get {
            return attributes[NSAttributedString.Key.backgroundColor] as? UIColor
        }
        set{
            setAttribute(name: NSAttributedString.Key.backgroundColor, value: newValue)
        }
    }
    func setBackColor(color: UIColor, range: NSRange? = nil) {
        setAttribute(name: NSAttributedString.Key.backgroundColor, value: color, range: range ?? base.wz.range)
    }
    
    /// 设置文字颜色
    var color: UIColor? {
        get {
            return attributes[NSAttributedString.Key.foregroundColor] as? UIColor
        }
        set{
            setAttribute(name: NSAttributedString.Key.foregroundColor, value: newValue)
        }
    }
    func setTextColor(color: UIColor, range: NSRange? = nil) {
        setAttribute(name: NSAttributedString.Key.foregroundColor, value: color, range: range ?? base.wz.range)
    }
    
    /// 设置下划线样式
    var underLineStyle: NSUnderlineStyle? {
        get {
            return attributes[NSAttributedString.Key.underlineStyle] as? NSUnderlineStyle
        }
        set{
            setAttribute(name: NSAttributedString.Key.underlineStyle, value: newValue)
        }
    }
    func setUnderLineStyle(lineStyle: NSUnderlineStyle, range: NSRange? = nil) {
        setAttribute(name: NSAttributedString.Key.underlineStyle, value: lineStyle, range: range ?? base.wz.range)
    }
    
    /// 设置文本段落样式的类
    var paragraphStyle: NSParagraphStyle? {
        get {
            return attributes[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle
        }
        set{
            setParagraphStyle(newValue ?? NSParagraphStyle.default)
        }
    }
    func setParagraphStyle(_ paragraphStyle: NSParagraphStyle, range: NSRange? = nil) {
        setAttribute(name: NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range ?? base.wz.range)
    }
    
    /// 可变段落
    private var mutableParagraphStyle: NSMutableParagraphStyle {
        guard let style = base.wz.paragraphStyle?.mutableCopy() as? NSMutableParagraphStyle else {
            return NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        }
        return style
    }
    
    /// 设置行间距
    var lineSpacing: CGFloat {
        get {
            return base.wz.paragraphStyle?.lineSpacing ?? 0
        }
        set{
            setLineSpace(newValue)
        }
    }
    func setLineSpace(_ lineSpace: CGFloat, range: NSRange? = nil){
        base.wz.mutableParagraphStyle.lineSpacing = lineSpace
        setParagraphStyle(base.wz.mutableParagraphStyle)
    }
    
    /// 文本对齐
    var alignment: NSTextAlignment {
        get {
            return base.wz.mutableParagraphStyle.alignment
        }
        set{
            setAlignment(newValue)
        }
    }
    func setAlignment(_ alignment: NSTextAlignment, range: NSRange? = nil){
        base.wz.mutableParagraphStyle.alignment = alignment
        setParagraphStyle(base.wz.mutableParagraphStyle)
    }
    
    /// 设置字体间距
    var kern: CGFloat? {
        get {
            return attributes[NSAttributedString.Key.kern] as? CGFloat
        }
        set{
            setAttribute(name: NSAttributedString.Key.kern, value: newValue)
        }
    }
    func setKern(_ value: CGFloat, range: NSRange? = nil) {
        setAttribute(name: NSAttributedString.Key.kern, value: value, range: range ?? base.wz.range)
    }
    
    /// 增加一个空白间距
    func setMarn(space: CGFloat, at: Int) {
        base.insert(NSAttributedString(string: " ", attributes: [.kern: space]), at: at)
    }
    
    /// 设置属性
    func setAttribute(name: NSAttributedString.Key, value: Any?, range: NSRange? = nil) {
        if name.rawValue.count==0 {
            return
        }
        guard let v = value else {
            return
        }
        
        let r = range ?? base.wz.range
        base.addAttribute(name, value: v, range: r)
    }
    
    /// 计算富文本高度
    func getContentHeight(with: CGFloat, maxHeight: CGFloat = CGFloat(MAXFLOAT) ) -> CGFloat {
        let frame = base.boundingRect(with: CGSize(width: with, height: maxHeight), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue), context: nil)
        return frame.size.height
    }
    
    /// 富文本添加图片
    func appendImageAttachment(image: UIImage?, point: CGPoint = .zero) {
        let attch = NSTextAttachment()
        attch.image = image
        let size = image?.size ?? .zero
        attch.bounds = CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
        let attachment = NSAttributedString(attachment: attch)
        base.append(attachment)
    }
    
    /// 塞入富文本
    func insertImageAttachment(image: UIImage?, at: Int) {
        let attch = NSTextAttachment()
        attch.bounds = CGRect(x: 0, y: 0, width: image?.size.width ?? 0, height: image?.size.height ?? 0)
        attch.image = image
        let attachment = NSAttributedString(attachment: attch)
        base.insert(attachment, at: at)
    }
    
    /// 获取字符出现的位置信息(支持多次位置获取)
    /// - Parameter string: 原始文本
    /// - Parameter inString: 需要查找的字符
    func rangeOfString(inString: String) -> [NSRange] {
        
        var arrRange = [NSRange]()
        let string = base.string as NSString
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
        return (base.string as NSString).range(of: of)
    }
}

/// MARK - 扩展
extension NSMutableAttributedString {
    
    /// 简易富文本
    public convenience init(string: String, lineSpacing: CGFloat? = nil, font: UIFont? = nil, color: UIColor? = nil) {
        self.init(string: string)
        
        if let f = font {
            self.wz.setFont(font: f)
        }
        
        if let l = lineSpacing {
            self.wz.setLineSpace(l)
        }
        if let c = color {
            self.wz.setTextColor(color: c)
        }
        
    }
}
