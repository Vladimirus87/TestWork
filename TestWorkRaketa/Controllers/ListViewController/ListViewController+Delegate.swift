//
//  ListViewController+Delegate.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: indexPath)
    }
    
    
    
    
}
