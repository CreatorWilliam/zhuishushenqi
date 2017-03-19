//
//  BookDetailAPI.swift
//  zhuishushenqi
//
//  Created by caonongyun on 16/10/4.
//  Copyright © 2016年 CNY. All rights reserved.
//

import UIKit

class BookDetailAPI: XYCBaseRequest {
    var id:NSString = ""
    
    override func requestUrl() -> String {
        return "/book/\(id)"
    }
    
    override func requestMethod() -> XYCRequestMethod? {
        return XYCRequestMethod.get
    }
    
    override func requestArgument() -> NSDictionary? {
        return ["":""]
    }
}
