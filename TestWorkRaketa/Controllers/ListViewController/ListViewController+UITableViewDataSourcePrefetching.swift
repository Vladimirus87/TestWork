//
//  ListViewController+UITableViewDataSourcePrefetching.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit

extension ListViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row == self.redditData.count - 1 {
                self.getData(lastID: self.redditData[index.row].name)
            }
        }
    }
    
}

