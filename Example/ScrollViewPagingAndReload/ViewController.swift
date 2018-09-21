//
//  ViewController.swift
//  ScrollViewPagingAndReload
//
//  Created by Angel on 09/21/2018.
//  Copyright (c) 2018 Angel. All rights reserved.
//

import UIKit
import ScrollViewPagingAndReload

class ViewController: UIViewController, ScrollViewPaging, ScrollViewReloadable {
    
    // MARK: ScrollViewReloadable
    var countPerPage: Int = 20
    var nextPageOffset: CGFloat = 100
    var nextPageClosure: (() -> ()) = ({})
    var loadingNextPageStatus: LoadingPageStatus = .loaded
    
    // MARK: ScrollViewReloadable
    var reloadOffset: CGFloat = -128.0
    var reloadClosure: (() -> ()) = ({})
    var reloadingStatus: ReloadingStatus = .loaded
    
    
    // MARK: Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Data source
    private var items: [Int] = Array(0...19)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Implement retrieving data for the next page
        nextPageClosure = ({
            self.activityIndicator.startAnimating()
            self.loadingNextPageStatus = .loadingNextPage // Set loadingNextPageStatus to loadingNextPage
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0, execute: {
                let nextItem = self.items.last! + 1
                let newLastItem = nextItem + self.countPerPage - 1
                
                self.items.append(contentsOf: Array(nextItem...newLastItem))
                
                DispatchQueue.main.async {
                    self.loadingNextPageStatus = self.items.count >= 100 ? .loadedAll : .loaded // Set loadingNextPageStatus to loadedAll if nothing more to load or loaded
                    self.reloadingStatus = .loaded
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            })
        })
        
        // Implement reloading the table
        reloadClosure = ({
            self.activityIndicator.startAnimating()
            self.reloadingStatus = .reloading // Set reloadingStatus to reloading
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0, execute: {
                self.items.removeAll()
                self.items.append(contentsOf: Array(0...19))
                
                DispatchQueue.main.async {
                    self.loadingNextPageStatus = .loaded
                    self.reloadingStatus = .loaded // Set reloadingStatus to loaded
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            })
        })
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.nextPage(scrollView: scrollView, currentCount: self.items.count)
        self.reload(scrollOffset: scrollView.contentOffset.y)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "BasicSell"
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
        
        cell?.textLabel?.text = "Row #\(items[indexPath.row] + 1)"
        
        return cell!
    }
}

