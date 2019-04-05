//
//  SharedTypes.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//  Copyright © 2018 George Lopez. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

#if os(iOS) || os(tvOS)
    
    typealias Font = UIFont
    typealias Color = UIColor
    
#elseif os(OSX)
    
    typealias Font = NSFont
    typealias Color = NSColor
    
#endif

