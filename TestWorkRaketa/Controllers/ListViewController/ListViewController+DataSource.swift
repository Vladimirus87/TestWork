//
//  ListViewController+DataSource.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditData.count + Int(truncating: NSNumber(value: isNotAllDataLoaded))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == redditData.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: loadingCellIdentifier, for: indexPath) as! LoadingCell
            cell.activity.tintColor = Colors.green.color()
            cell.activity.startAnimating()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: redditCellIdentifier, for: indexPath) as! RedditListCell
            cell.updateData(self.redditData[indexPath.row])
            cell.delegate = self
            return cell
        }
       
    }
    
}
