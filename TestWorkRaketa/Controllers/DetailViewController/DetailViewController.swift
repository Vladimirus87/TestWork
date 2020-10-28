//
//  DetailViewController.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let minimumZoomScale: CGFloat = 1
    private let maximumZoomScale: CGFloat = 6
    
    var imageUrl: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
        uiSettings()
        loadImage(imageUrl)
    }
    
    
    private func addGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(gestureRecognizer:)))
        tapRecognizer.numberOfTapsRequired = 2
        picture.addGestureRecognizer(tapRecognizer)
        picture.isUserInteractionEnabled = true
    }
    
    private func uiSettings() {
        activity.color = Colors.green.color()
        scrollView.minimumZoomScale = minimumZoomScale
        scrollView.maximumZoomScale = maximumZoomScale
    }
    
    private func loadImage(_ urlString: String?) {
        
        guard let urlStr = urlString,
              let url = URL(string: urlStr) else {return}

        activity.isHidden = false
        activity.startAnimating()
        DispatchQueue.global(qos: .utility).async {
            ImageLoader.shared.loadImage(url: url, completion: { (img) in
                DispatchQueue.main.async {
                    self.activity.stopAnimating()
                    if let image = img {
                        self.picture.image = image
                    } else {
                        self.picture.image = #imageLiteral(resourceName: "image_not_available")
                    }
                }
            })
        }
    }
    
    
    @objc private func onDoubleTap(gestureRecognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale < maximumZoomScale {
            let scale = maximumZoomScale
            
            let point = gestureRecognizer.location(in: picture)
            
            let scrollSize = scrollView.frame.size
            let size = CGSize(width: scrollSize.width / scale,
                              height: scrollSize.height / scale)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
        } else {
            scrollView.setZoomScale(minimumZoomScale, animated: true)
        }


    }
    
    func zoomRectForScale(scale : CGFloat, center : CGPoint) -> CGRect {
            var zoomRect = CGRect.zero
            if let imageV = self.picture {
                zoomRect.size.height = imageV.frame.size.height / scale;
                zoomRect.size.width  = imageV.frame.size.width  / scale;
                let newCenter = imageV.convert(center, from: view)
                zoomRect.origin.x = newCenter.x - ((zoomRect.size.width / 2.0));
                zoomRect.origin.y = newCenter.y - ((zoomRect.size.height / 2.0));
            }
            return zoomRect;
        }
}

