//
//  ListViewController.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableViewData: UITableView!
    
    let cellIdentifier = "RedditListCell"
    let segueIdentifier = "ToDetailVC"
    let cellHeight: CGFloat = 136
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.orange
        
        return refreshControl
    }()
    
    lazy var redditData = [ChildData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initXibs()
        self.uiSettings()
        self.getData()
    }
    
    private func initXibs() {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableViewData.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func uiSettings() {
        title = "Reddit"
        self.tableViewData.rowHeight = UITableView.automaticDimension
        self.tableViewData.estimatedRowHeight = cellHeight
        self.tableViewData.addSubview(self.refreshControl)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.getData()
        self.tableViewData.reloadData()
        refreshControl.endRefreshing()
    }

    func getData(lastID: String? = nil){
        RedditClient.shared.getTopData(afterID: lastID){ (data, error) in
            guard error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                if lastID == nil {
                    self.redditData = []
                }
                  
                self.redditData.append(contentsOf: data)
                self.tableViewData.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destinationVC = segue.destination as? 
    }
}
