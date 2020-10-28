//
//  ListViewController+DataSource.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RedditListCell
        
        cell.updateData(self.redditData[indexPath.row])
        
        if (indexPath.row + 1 == self.redditData.count) {
            self.getData(lastID: self.redditData[indexPath.row].name)
            self.tableViewData.reloadData()
        }
        
        return cell
    }
        
}
