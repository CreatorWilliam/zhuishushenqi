//
//  ZSSearchBookViewModel.swift
//  zhuishushenqi
//
//  Created by caony on 2019/10/22.
//  Copyright © 2019 QS. All rights reserved.
//

import UIKit
import ZSAPI

class ZSSearchBookViewModel {
    
    var viewDidLoad: ()->() = {}
    var reloadBlock: ()->() = {}
    
    var searchHotwords:[ZSSearchHotwords] = []
    var hotword:[ZSHotWord] = []

    init() {
        viewDidLoad = { [weak self] in
            self?.request()
        }
    }
    
    func request() {
        requestSearchHotwords { [weak self] in
            self?.reloadBlock()
        }
        requestHotWord { [weak self] in
            self?.reloadBlock()
        }
    }
    
    private func requestSearchHotwords(completion:@escaping()->Void) {
        let api = ZSAPI.searchHotwords("" as AnyObject)
        zs_get(api.path) { [unowned self] (json) in
            guard let searchHotwordsDict = json?["searchHotWords"] as? [[String:Any]] else {
                completion()
                return
            }
            guard let searchModels = [ZSSearchHotwords].deserialize(from: searchHotwordsDict) as? [ZSSearchHotwords] else {
                completion()
                return
            }
            self.searchHotwords = searchModels
            completion()
        }
    }
    
    private func requestHotWord(completion:@escaping()->Void) {
        let api = ZSAPI.hotwords("" as AnyObject)
        zs_get(api.path) { [unowned self] (json) in
            guard let searchHotwordsDict = json?["newHotWords"] as? [[String:Any]] else {
                completion()
                return
            }
            guard let searchModels = [ZSHotWord].deserialize(from: searchHotwordsDict) as? [ZSHotWord] else {
                completion()
                return
            }
            self.hotword = searchModels
            completion()
        }
    }
}
