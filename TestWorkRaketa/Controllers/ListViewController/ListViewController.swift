//
//  ListViewController.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableViewData: UITableView!
    
    let redditCellIdentifier = "RedditListCell"
    let loadingCellIdentifier = "LoadingCell"
    let detailSegueIdentifier = "ToDetailVC"
    let webVCSegueIdentifier = "toWebVC"
    let cellHeight: CGFloat = 136
    
    /// Checks if all data has been loaded. If true, there is still data. false - all data loaded
    var isNotAllDataLoaded = true
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Colors.green.color()
        return refreshControl
    }()
    
    lazy var redditData = [ChildData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initXibs()
        self.uiSettings()
        self.getData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let urlString = sender as? String else { return }
        print(urlString)
        if let destinationVC = segue.destination as? DetailViewController {
            destinationVC.imageUrl = urlString
        } else if let destinationVC = segue.destination as? WebViewController {
            destinationVC.urlString = urlString
        }
        navigationItem.backBarButtonItem = UIBarButtonItem()
    }
    
    private func initXibs() {
        let redditNib = UINib(nibName: redditCellIdentifier, bundle: nil)
        tableViewData.register(redditNib, forCellReuseIdentifier: redditCellIdentifier)
        let loadingNib = UINib(nibName: loadingCellIdentifier, bundle: nil)
        tableViewData.register(loadingNib, forCellReuseIdentifier: loadingCellIdentifier)
    }
    
    private func uiSettings() {
        title = "Reddit"
        self.tableViewData.addSubview(self.refreshControl)
        self.tableViewData.tableFooterView = UIView()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.getData()
        self.tableViewData.reloadData()
        refreshControl.endRefreshing()
    }

    ///Load listing data from Reddit Api
    func getData(lastID: String? = nil) {
        DispatchQueue.global(qos: .userInteractive).async {
            RedditClient.shared.getTopData(afterID: lastID) { (data, error) in
                guard error == nil else {
                    DispatchQueue.main.async {
                        self.errorHandler(error!)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    if lastID == nil {
                        self.redditData = []
                        self.isNotAllDataLoaded = true
                    }
                    
                    self.redditData.append(contentsOf: data)
                    self.isNotAllDataLoaded = !data.isEmpty
                    
                    self.tableViewData.reloadData()
                }
            }
        }
    }
    
    
}
