//
//  UIButton+.swift
//  WZLY
//
//  Created by xiaobin liu on 2020/3/16.
//  Copyright © 2020 我主良缘. All rights reserved.
//

import UIKit

private struct WZButtonCustomEdgeInset {
    static var top: String = "topkey"
    static var left: String = "leftkey"
    static var bottom: String = "botkey"
    static var right: String = "rightkey"
}

/// MARK - 按钮
public extension NamespaceWrappable where Base: UIButton {
    
    enum RGButtonImagePosition {
    case top          //图片在上，文字在下，垂直居中对齐
    case bottom       //图片在下，文字在上，垂直居中对齐
    case left         //图片在左，文字在右，水平居中对齐
    case right        //图片在右，文字在左，水平居中对齐
    }
    
    
    
    /// 按钮禁用状态图像
    var imageForDisabled: UIImage? {
        get {
            return base.image(for: .disabled)
        }
        set {
            base.setImage(newValue, for: .disabled)
        }
    }
    
    /// 按钮高亮显示状态的图像
    var imageForHighlighted: UIImage? {
        get {
            return base.image(for: .highlighted)
        }
        set {
            base.setImage(newValue, for: .highlighted)
        }
    }
    
    /// 按钮的正常状态图像
    var imageForNormal: UIImage? {
        get {
            return base.image(for: .normal)
        }
        set {
            base.setImage(newValue, for: .normal)
        }
    }
    
    /// 按钮的选定状态图像
    var imageForSelected: UIImage? {
        get {
            return base.image(for: .selected)
        }
        set {
            base.setImage(newValue, for: .selected)
        }
    }
    
    /// 按钮的禁用状态的标题颜色
    var titleColorForDisabled: UIColor? {
        get {
            return base.titleColor(for: .disabled)
        }
        set {
            base.setTitleColor(newValue, for: .disabled)
        }
    }
    
    /// 按钮突出显示状态的标题颜色
    var titleColorForHighlighted: UIColor? {
        get {
            return base.titleColor(for: .highlighted)
        }
        set {
            base.setTitleColor(newValue, for: .highlighted)
        }
    }
    
    /// 按钮的正常状态的标题颜色
    var titleColorForNormal: UIColor? {
        get {
            return base.titleColor(for: .normal)
        }
        set {
            base.setTitleColor(newValue, for: .normal)
        }
    }
    
    /// 按钮的选择状态的标题颜色
    var titleColorForSelected: UIColor? {
        get {
            return base.titleColor(for: .selected)
        }
        set {
            base.setTitleColor(newValue, for: .selected)
        }
    }
    
    /// 按钮的禁用状态标题
    var titleForDisabled: String? {
        get {
            return base.title(for: .disabled)
        }
        set {
            base.setTitle(newValue, for: .disabled)
        }
    }
    
    /// 按钮的突出显示状态标题
    var titleForHighlighted: String? {
        get {
            return base.title(for: .highlighted)
        }
        set {
            base.setTitle(newValue, for: .highlighted)
        }
    }
    
    /// 按钮的正常状态标题
    var titleForNormal: String? {
        get {
            return base.title(for: .normal)
        }
        set {
            base.setTitle(newValue, for: .normal)
        }
    }
    
    /// 按钮的选定状态标题
    var titleForSelected: String? {
        get {
            return base.title(for: .selected)
        }
        set {
            base.setTitle(newValue, for: .selected)
        }
    }
    
    /// 按钮背景图片
    var backgroundImageNormal: UIImage? {
        
        get {
            return base.backgroundImage(for: .normal)
        }
        set {
            base.setBackgroundImage(newValue, for: .normal)
        }
    }
    
    
    /// 状态
    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }
    
    /// 所有状态设置图像。
    ///
    /// - Parameter image: 图像
    func setImageForAllStates(_ image: UIImage) {
        states.forEach { base.setImage(image, for: $0) }
    }
    
    
    /// 为所有状态设置标题颜色
    ///
    /// - Parameter color: 颜色
    func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { base.setTitleColor(color, for: $0) }
    }
    
    /// 为所有状态设置标题
    ///
    /// - Parameter title: 标题.
    func setTitleForAllStates(_ title: String) {
        states.forEach { base.setTitle(title, for: $0) }
    }
    
    /// 中心对齐标题文本和图像在UIButton
    ///
    /// - Parameter spacing: 在UIButton标题文本和UIButton图像之间的间隔。
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        
        if UIView.appearance().semanticContentAttribute == .forceRightToLeft {
            base.imageEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            base.titleEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            base.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }else{
            base.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            base.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            base.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }
    
    /// 右侧图片
    func titleImageHorizontalAlignmentwith(_ space: Int, imageBottom: Int = 0) {
        
        self.resetEdgeInsets()
        
        let contentRect = base.contentRect(forBounds: base.bounds)
        let titleSize = base.titleRect(forContentRect: contentRect).size
        let imageSize = base.imageRect(forContentRect: contentRect).size
        
        if UIView.appearance().semanticContentAttribute == .forceRightToLeft {
            base.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat(space))
            base.titleEdgeInsets = UIEdgeInsets(top: 0, left: imageSize.width, bottom: 0, right: imageSize.width)
            base.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width+CGFloat(space), bottom: CGFloat(imageBottom), right: titleSize.width-CGFloat(space))
        }else{
            base.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat(space))
            base.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: 0, right: imageSize.width)
            base.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width+CGFloat(space), bottom: CGFloat(imageBottom), right: -titleSize.width-CGFloat(space))
        }
    }
    
    /// 左侧图片
    func imageTitleHorizontalAlignmentWith(_ space: Int, titleBottom: Int = 0) {
        
        self.resetEdgeInsets()
        base.titleEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat(space), bottom: CGFloat(titleBottom), right: -CGFloat(space))
        base.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat(space))
    }
    
    
    /// 图片位于下方
    func titleImageVerticalAlignmentWith(_ space: Int) {
        self.verticalAlignmentWithTitle(true, space: space)
    }
    
    
    /// 图片位于上方
    func imageTitleVerticalAlignmentWith(_ space: Int) {
        self.verticalAlignmentWithTitle(false, space: space)
    }
    
    
    fileprivate func verticalAlignmentWithTitle(_ isTop: Bool, space: Int) {
        
        self.resetEdgeInsets()
        
        let contentRect = base.contentRect(forBounds: base.bounds)
        let titleSize = base.titleRect(forContentRect: contentRect).size
        let imageSize = base.imageRect(forContentRect: contentRect).size
        
        
        let halfWidth = (titleSize.width + imageSize.width)/2
        let halfHeight = (titleSize.height + imageSize.height)/2
        
        let topInset = min(halfHeight, titleSize.height)
        let leftInset = (titleSize.width - imageSize.width)>0 ? (titleSize.width - imageSize.width)/2 : 0
        let bottomInset = (titleSize.height - imageSize.height)>0 ? (titleSize.height - imageSize.height)/2 : 0
        let rightInset = min(halfWidth, titleSize.width)
        
        if isTop {
            base.titleEdgeInsets = UIEdgeInsets(top: -halfHeight-CGFloat(space), left: -halfWidth, bottom: halfHeight+CGFloat(space), right: halfWidth)
            base.contentEdgeInsets = UIEdgeInsets(top: topInset+CGFloat(space), left: leftInset, bottom: -bottomInset, right: -rightInset)
        } else {
            base.titleEdgeInsets = UIEdgeInsets(top: halfHeight+CGFloat(space), left: -halfWidth, bottom: -halfHeight-CGFloat(space), right: halfWidth)
            base.contentEdgeInsets = UIEdgeInsets(top: -bottomInset, left: leftInset, bottom: topInset+CGFloat(space), right: -rightInset)
        }
    }
    
    
    fileprivate func resetEdgeInsets() {
        base.contentEdgeInsets = UIEdgeInsets.zero
        base.imageEdgeInsets = UIEdgeInsets.zero
        base.titleEdgeInsets = UIEdgeInsets.zero
    }
    
    /// - Description 设置Button图片的位置
    /// - Parameters:
    ///   - style: 图片位置
    ///   - spacing: 按钮图片与文字之间的间隔
    func imagePosition(style: RGButtonImagePosition, spacing: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = base.imageView?.frame.size.width
        let imageHeight = base.imageView?.frame.size.height
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        labelWidth = base.titleLabel?.intrinsicContentSize.width
        labelHeight = base.titleLabel?.intrinsicContentSize.height
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
        //上 左 下 右
        imageEdgeInsets = UIEdgeInsets(top: -labelHeight-spacing/2, left: 0, bottom: 0, right: -labelWidth)
        labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-spacing/2, right: 0)
        break;
        case .left:
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing)
        labelEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        break;
        case .bottom:
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-spacing/2, right: -labelWidth)
        labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-spacing/2, left: -imageWidth!, bottom: 0, right: 0)
        break;
        case .right:
        imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+spacing/2, bottom: 0, right: -labelWidth-spacing/2)
        labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-spacing/2, bottom: 0, right: imageWidth!+spacing/2)
        break;
        }
        base.titleEdgeInsets = labelEdgeInsets
        base.imageEdgeInsets = imageEdgeInsets
    }
    
    /// 设置边界
    func setEnlargeEdge(_ edge: CGFloat) {
        base.setEnlargeEdge(edge, edge, edge, edge)
    }
}


private var topEnlargeKey: UInt8 = 2
private var botEnlargeKey: UInt8 = 3
private var leftEnlargeKey: UInt8 = 4
private var rightEnlargeKey: UInt8 = 5
/// MARK - 按钮点击范围
extension UIButton {
    
    /// 设置按钮边界
    func setEnlargeEdge(_ top: CGFloat,_ bot: CGFloat,_ left: CGFloat,_ right: CGFloat) {

        objc_setAssociatedObject(self, &topEnlargeKey, top, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &botEnlargeKey, bot, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &leftEnlargeKey, left, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &rightEnlargeKey, right, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /// 获取边界
    private func returnRect() -> CGRect{
        
        guard let top = objc_getAssociatedObject(self, &topEnlargeKey) as? CGFloat,
                let left = objc_getAssociatedObject(self, &botEnlargeKey) as? CGFloat,
                let bot = objc_getAssociatedObject(self,  &leftEnlargeKey) as? CGFloat,
              let right = objc_getAssociatedObject(self, &rightEnlargeKey) as? CGFloat else {
            return self.bounds
        }
        return CGRect(x: self.bounds.origin.x-left,
                      y: self.bounds.origin.y-top,
                      width: self.bounds.size.width+left+right,
                      height: self.bounds.size.height+top+bot)
    }
    
    
    /// 重写系统事件
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if (self.isHidden || self.alpha == 0.0) {
            return super.hitTest(point, with: event)
        }
        
        let rect = returnRect()
        if (CGRectEqualToRect(rect, self.bounds)) {
            return super.hitTest(point, with: event)
        }
        return CGRectContainsPoint(rect, point) ? self : nil;
    }
}

