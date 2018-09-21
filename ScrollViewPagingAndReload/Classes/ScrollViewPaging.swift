//
//  ScrollViewPaging.swift
//  UIScrollViewPagingAndReload
//
//  Created by Angel on 21.09.18.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import UIKit

public enum LoadingPageStatus: String {
    case loaded, loadingNextPage, loadedAll
}

public protocol ScrollViewPaging: class {
    /**
     Count of items per page. Used to check if last page is reached.
     */
    var countPerPage: Int {get set}
    
    /**
     Offset before the end needed to triger loading of the next page.
     */
    var nextPageOffset: CGFloat {get set}
    
    /**
     Closure to be executed once next page loading is trigerred.
     */
    var nextPageClosure: (() -> ()) {get set}
    
    /**
     Current loading status.
     */
    var loadingNextPageStatus: LoadingPageStatus {get set}
    
    /**
     Method which starts next page loading.
     */
    func nextPage(scrollView: UIScrollView, currentCount: Int)
}

extension ScrollViewPaging {
    func nextPage(scrollView: UIScrollView, currentCount: Int) {
        // If all items are loaded don't try to load more.
        // If currently loading next page don't try to load again.
        // If content size height is zero don't try to load anything.
        // If content offset is below 0.0 it cannot be a call for next page.
        // If content size height is smaller than scroll view's height no need to load anything.
        
        // NB!!! Check if the scroll view is not under a top navigation bar.
        // If that is the case adjust the -44.0 or delete it
        if self.loadingNextPageStatus == .loadedAll
            || self.loadingNextPageStatus == .loadingNextPage
            || scrollView.contentSize.height == 0
            || scrollView.contentOffset.y < 0.0
            || scrollView.contentSize.height < scrollView.frame.height - 44.0 {
            return
        }
        
        // If there are more things to load and nextPageOffset is reached load next page
        if currentCount % countPerPage == 0 && scrollView.contentSize.height - nextPageOffset < scrollView.contentOffset.y + scrollView.frame.height {
            self.loadingNextPageStatus = .loadingNextPage
            self.nextPageClosure()
        } // else if no more things left to be loaded set as LoadedAll
        else if currentCount % countPerPage != 0 {
            self.loadingNextPageStatus = .loadedAll
        }
    }
}
