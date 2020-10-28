//
//  ListViewController+RedditListCellDelegate.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit

extension ListViewController: RedditListCellDelegate {
    
    func imageTapped(cell: UITableViewCell) {
        guard let indexPath = tableViewData.indexPath(for: cell) else {
            return
        }
        
        guard let urlString = redditData[indexPath.row].imageUrl else {
            showErrorAlert(msg: "No any links, try another picture.")
            return
        }

        let availableFormats = ["png", "jpg"]

        if let format = urlString.split(separator: ".").last,
           availableFormats.contains(String(format)) {
            performSegue(withIdentifier: detailSegueIdentifier, sender: urlString)
        } else {
            performSegue(withIdentifier: webVCSegueIdentifier, sender: urlString)
//            showErrorAlert(msg: "Unknown format")
        }
        
        
    }
    
    
}
