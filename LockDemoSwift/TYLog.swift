//
//  TYLog.swift
//  toeflKMF
//
//  Created by 岳琛 on 2019/7/10.
//  Copyright © 2019 com.enhance. All rights reserved.
//

import UIKit
import Foundation

public func TYLog (
    _ message: Any?,
    _ attributes: [CVarArg] = [],
    fielPath: String = #file,
    function: String = #function,
    line: Int = #line,
    isShowSystemInfo: Bool = true) {
    
    guard message != nil else {
        TYLogNothing(fielPath, function: function, line: line)
        return
    }
    
    #if DEBUG
    guard let message = message else { return }
    
    var s: String
    func curriedStringWithFormat(valist:CVaListPointer) -> String {
        return NSString(format: "\(message)", arguments:valist) as String
    }
    
    if isShowSystemInfo {
        let file = fielPath.lastPathComponent
        s = "\(line): \(file) -> \(function)\r" + withVaList(attributes, curriedStringWithFormat)
    } else {
        s = withVaList(attributes, curriedStringWithFormat)
    }
    
    print(s)
    #endif
}

public func TYLog (
    _ messages: Any?...,
    separator: String = " ",
    terminator: String = "\r",
    fielPath: String = #file,
    function: String = #function,
    line: Int = #line,
    isShowSystemInfo: Bool = true) {
    
    guard messages.isEmpty == false else {
        TYLogNothing(fielPath, function: function, line: line)
        return
    }
    
    #if DEBUG
    var messageString = ""
    messages.forEach { (message) in
        messageString.append("\(message ?? "NULL")" + separator)
    }
    messageString.removeLast()
    messageString.append(terminator)
    
    var s: String
    if isShowSystemInfo {
        let file = fielPath.lastPathComponent
        s = "\(line): \(file) -> \(function)\r" + messageString
    } else {
        s = messageString
    }
    print(s)
    #endif
}

private func TYLogNothing(_ fielPath: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    let s = "\(line): \(fielPath.lastPathComponent) -> \(function)"
    print(s)
    #endif
}

fileprivate extension String {
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent as String
    }
}
