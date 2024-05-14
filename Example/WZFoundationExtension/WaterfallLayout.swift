//
//  WaterfallLayout.swift
//  Created by CocoaPods on 2024/4/17
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2024. All rights reserved.
//  @author qiuqixiang(739140860@qq.com)   
//

import UIKit

class WaterfallLayout: UICollectionViewFlowLayout {
    weak var delegate: WaterfallLayoutDelegate?
    var columnCount: Int = 2 // 瀑布流列数
    var columnSpacing: CGFloat = 10.0 // 列间距
    var itemSpacing: CGFloat = 10.0 // 单元格间距
    
    var cache: [UICollectionViewLayoutAttributes] = []
    
    private var columnHeights: [CGFloat] = []
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        columnHeights = Array(repeating: sectionInset.top, count: columnCount)
        
        let availableWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right - CGFloat(columnCount - 1) * columnSpacing
        let itemWidth = (availableWidth / CGFloat(columnCount)).rounded(.down)
        
        var xOffset: [CGFloat] = []
        for column in 0..<columnCount {
            xOffset.append(sectionInset.left + CGFloat(column) * (itemWidth + columnSpacing))
        }
        
        var yOffset: [CGFloat] = Array(repeating: 0, count: columnCount)
        
        var attributes: [UICollectionViewLayoutAttributes] = []
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let shortestColumn = yOffset.firstIndex(of: yOffset.min()!) ?? 0
            let x = xOffset[shortestColumn]
            let y = yOffset[shortestColumn]
            let height = delegate?.collectionView(collectionView, heightForItemAt: indexPath) ?? 100
            let frame = CGRect(x: x, y: y, width: itemWidth, height: height)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = frame
            attributes.append(attribute)
            
            yOffset[shortestColumn] += height + itemSpacing
        }
        
        let maxColumnHeight = yOffset.max()! - itemSpacing + sectionInset.bottom
        columnHeights = Array(repeating: maxColumnHeight, count: columnCount)
        
        cache.removeAll()
        cache.append(contentsOf: attributes)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache 
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return .zero }
        let contentHeight = columnHeights.max() ?? 0
        return CGSize(width: collectionView.bounds.width, height: contentHeight)
    }
}

protocol WaterfallLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat
}
