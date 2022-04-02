//
//  HeaderFooter.swift
//  Jenga
//
//  Created by 方林威 on 2022/4/1.
//

import UIKit

public struct HeaderFooter {
    
    var height: CGFloat?
    var content: Content?
    
    var title: String? {
        switch content {
        case .string(let value):    return value
        case .view:                 return nil
        case .none:                 return nil
        }
    }
    
    var view: UIView? {
        switch content {
        case .string:               return nil
        case .view(let value):      return value
        case .none:                 return nil
        }
    }
    
    enum Content {
        case string(String?)
        case view(UIView?)
    }
    
    public init() {
        self.height = nil
        self.content = nil
    }
}


public protocol Header {
    
    var header: HeaderFooter { get set }
    
    var rowHeight: CGFloat? { get set }
    
    var hiddenWithEmpty: Bool { get set }
}

public protocol Footer {
    
    var footer: HeaderFooter { get set }
    
    var rowHeight: CGFloat? { get set }
    
    var hiddenWithEmpty: Bool { get set }
}

public struct TableHeader: Header {
    
    public var header = HeaderFooter()
    
    public var rowHeight: CGFloat?
    
    public var hiddenWithEmpty: Bool = false
    
    public init() { }
    
    public init(_ value: @autoclosure () -> (String?)) {
        header.content = .string(value())
    }

    public init(_ value: @autoclosure () -> (UIView?)) {
        header.content = .view(value())
    }
}

public struct TableFooter: Footer {
    
    public var footer = HeaderFooter()
    
    public var rowHeight: CGFloat?
    
    public var hiddenWithEmpty: Bool = false
    
    public init() { }
    
    public init(_ value: @autoclosure () -> (String?)) {
        footer.content = .string(value())
    }

    public init(_ value: @autoclosure () -> (UIView?)) {
        footer.content = .view(value())
    }
}

extension TableHeader: Update { }
extension TableFooter: Update { }

public extension TableHeader {
    
    func height(_ value: @autoclosure () -> (CGFloat)) -> Self {
        update { $0.header.height = value() }
    }
    
    func hiddenWithEmpty(_ value: Bool) -> Self {
        update { $0.hiddenWithEmpty = value }
    }
    
    func rowHeight(_ value: @autoclosure () -> (RowHeight)) -> Self {
        update { $0.rowHeight = value() }
    }
}

public extension TableFooter {

    func height(_ value: @autoclosure () -> (CGFloat)) -> Self {
        update { $0.footer.height = value() }
    }
    
    func hiddenWithEmpty(_ value: Bool) -> Self {
        update { $0.hiddenWithEmpty = value }
    }
    
    func rowHeight(_ value: @autoclosure () -> (RowHeight)) -> Self {
        update { $0.rowHeight = value() }
    }
}
