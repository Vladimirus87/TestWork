//
//  WebViewController.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
        
    @IBOutlet weak var webViewBackground: UIView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    private var webView: WKWebView!
    
    var urlString: String?
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        uiSettings()
        
        guard let _urlString = urlString, let url = URL(string: _urlString) else {
            showErrorAlert(msg: "Incorrect Url")
            return
        }
        startLoadAnimation()
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func uiSettings() {
        webView.backgroundColor = .black
        webViewBackground.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: webViewBackground.topAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: webViewBackground.bottomAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: webViewBackground.trailingAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: webViewBackground.leadingAnchor, constant: 0).isActive = true
        webViewBackground.bringSubviewToFront(activity)
        activity.color = Colors.green.color()
    }
    
    func startLoadAnimation() {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func stopLoadAnimation() {
        activity.isHidden = true
        activity.stopAnimating()
    }

}


