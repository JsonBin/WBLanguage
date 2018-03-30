//
//  YNSlackMaker.swift
//  YNFoundation
//
//  Created by uneed-zwb on 2018/3/30.
//  Copyright © 2018年 com.uneed.yuni. All rights reserved.
//

import Foundation

public final class YNSlackMaker {

    /// 缓存String数组，只读
    public var vlaues: [String] {
        return _values
    }

    private var _values: [String]
    private let _protocol: YNSlackProtocol
    private let _lock = NSRecursiveLock()

    public init(_ values: [String] = [], _ pro: YNSlackProtocol) {
        self._values = values
        self._protocol = pro
    }

    /// 外部注入数据，为单个字符串
    ///
    /// - Parameters:
    ///   - string: 需要注入的字符串
    ///   - update: 是否需要更新界面
    public func push(string: String?, _ update: Bool = true) {
        _lock.lock()
        defer { _lock.unlock() }
        guard let string = string else { return }
        _values.append(string)
        if update {
            _protocol.update()
        }
    }

    /// 移除单个字符串
    ///
    /// - Parameter string: 需要移除的字符串
    /// - Returns: 返回移除的字符串，成功返回移除的字符串，失败返回nil
    @discardableResult
    public func pop(string: String) -> String? {
        _lock.lock()
        defer { _lock.unlock() }
        guard let index = _values.index(of: string) else {
            return nil
        }
        return _values.remove(at: index)
    }

    /// 移除末尾的字符
    ///
    /// - Parameter count: 需要移除的末尾字符的个数
    /// - Returns: 移除之后组成新的字符串
    @discardableResult
    public func popEnd(count: Int) -> String {
        _lock.lock()
        defer { _lock.unlock() }
        for _ in 0..<count {
            if !_values.isEmpty {
                _values.removeLast()
            }
        }
        return _values.joined()
    }

    /// 移除最后一个字符
    ///
    /// - Returns: 移除的字符
    @discardableResult
    public func popLast() -> String? {
        _lock.lock()
        defer { _lock.unlock() }
        if !_values.isEmpty {
            return _values.removeLast()
        }
        return nil
    }

    /// 移除所有的字符
    public func popAll() {
        _lock.lock()
        defer { _lock.unlock() }
        _values.removeAll()
    }
}
