//
//  DelegateClassSwap.swift
//  TestSwapSDK
//
//  Created by WebvilleeMAC on 05/04/18.
//  Copyright © 2018 Webvillee. All rights reserved.
//

import UIKit

public class DelegateClassSwap: NSObject {
    public var delegatee:AnyObject?
    public var callBackk:Selector?
    public static let shared = DelegateClassSwap()
    
    public override init() {
        super.init()
        
    }
    
    public func initWithDelegate(delegate:AnyObject , callBack:Selector) -> Any
    {
        delegatee = delegate
        callBackk = callBack
        return self
    }
    func callDelegate() {
        print("NSObject delegate called")
        _ = delegatee?.perform(callBackk)
    }
}
