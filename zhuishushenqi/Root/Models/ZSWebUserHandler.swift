//
//  ZSWebUserHandler.swift
//  zhuishushenqi
//
//  Created by caonongyun on 2019/6/30.
//  Copyright © 2019 QS. All rights reserved.
//

import UIKit

class ZSWebUserHandler: ZSWebEventHandlerProtocol {
    func handleWebItem(item: ZSWebItem, context: ZSWebContext, block: (String) -> Void) {
        
    }
    
    
    static func canHandleWebItem(item:ZSWebItem) ->Bool {
        
        
        return true
    }
}
