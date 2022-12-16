//
//  Queue.swift
//  WZLY
//
//  Created by xiaobin liu on 2020/4/17.
//  Copyright © 2020 我主良缘. All rights reserved.
//

import Foundation

// 定义一个队列结构
public struct Queue<T> {
    
    // 数组用来存储数据元素
    fileprivate var data = [T]()
    
    // 构造方法，用于构建一个空的队列
    public init() {}
    
    // 构造方法，用于从序列中创建队列
    public init<S: Sequence>(_ elements: S) where
        S.Iterator.Element == T {
            data.append(contentsOf: elements)
    }
    
    // 将类型为T的数据元素添加到队列的末尾
    public mutating func enqueue(element: T) {
        data.append(element)
    }
    
    // 移除并返回队列中第一个元素
    // 如果队列不为空，则返回队列中第一个类型为T的元素；否则，返回nil。
    @discardableResult
    public mutating func dequeue() -> T? {
        if data.count > 0 {
           return data.removeFirst()
        }
        return nil
    }
    
    // 返回队列中的第一个元素，但是这个元素不会从队列中删除
    // 如果队列不为空，则返回队列中第一个类型为T的元素；否则，返回nil。
    public func peek() -> T? {
        return data.first
    }
    
    
    // 清空队列中的数据元素
    public mutating func clear() {
        data.removeAll()
    }
    
    
    // 返回队列中数据元素的个数
    public var count: Int {
        return data.count
    }
    
    // 返回或者设置队列的存储空间
    public var capacity: Int {
        get {
            return data.capacity
        }
        set {
            data.reserveCapacity(newValue)
        }
    }
    
    // 检查队列是否已满
    // 如果队列已满，则返回true；否则，返回false
    public func isFull() -> Bool {
        return count == data.capacity
    }
    
    // 检查队列是否为空
    // 如果队列为空，则返回true；否则，返回false
    public func isEmpty() -> Bool {
        return data.isEmpty
    }
    
    // 确保队列中的索引是合法的
    fileprivate func checkIndex(index: Int) {
        if index < 0 || index > count {
            fatalError("Index out of range")
        }
    }
}


// 让打印队列时输出简介的格式
extension Queue: CustomStringConvertible, CustomDebugStringConvertible {
    
    // 控制打印队列时的文本输出
    public var description: String {
        return data.description
    }
    
    // 控制打印队列时的文本输出，主要用于调试
    public var debugDescription: String {
        return data.debugDescription
    }
}

// 让队列支持通过快速声明来创建实例
extension Queue: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }
}


// 扩展队列的for...in循环功能
extension Queue: Sequence {
    
    // 从序列中返回一个迭代器
    public func generate() -> AnyIterator<T> {
        return AnyIterator(IndexingIterator(_elements: data.lazy))
    }
}

// 根据索引返回指定的位置
extension Queue: Collection {
    
    // i的值必须比endIndex小
    public func index(after i: Int) -> Int {
        // 返回i后面的索引
        return data.index(after: i)
    }
}

// 实现下标功能
extension Queue: MutableCollection {
    
    // 队列的起始索引
    public var startIndex: Int {
        return 0
    }
    
    // 队列末尾索引
    public var endIndex: Int {
        return count - 1
    }
    
    // 获取或者设置下标
    public subscript(index: Int) -> T {
        get {
            checkIndex(index: index)
            return data[index]
        }
        
        set {
            checkIndex(index: index)
            data[index] = newValue
        }
    }
}
