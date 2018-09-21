//
//  ScrollViewReloadable.swift
//  UIScrollViewPagingAndReload
//
//  Created by Angel on 21.09.18.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import UIKit

public enum ReloadingStatus: String {
    case loaded, reloading
}

public protocol ScrollViewReloadable: class {
    /**
     Offset needed to triger reloading.
     */
    var reloadOffset: CGFloat {get set}
    
    /**
     Closure to be executed once reloading is trigerred.
     */
    var reloadClosure: (() -> ()) {get set}
    
    /**
     Current reloading status.
     */
    var reloadingStatus: ReloadingStatus {get set}
    
    /**
     Method which starts the reloading if needed.
     */
    func reload(scrollOffset: CGFloat)
}

extension ScrollViewReloadable {
    func reload(scrollOffset: CGFloat) {
        if scrollOffset <= self.reloadOffset && self.reloadingStatus != .reloading {
            self.reloadingStatus = .reloading
            self.reloadClosure()
        }
    }
}
