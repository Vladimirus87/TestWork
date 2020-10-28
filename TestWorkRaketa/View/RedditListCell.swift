//
//  RedditListCell.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit

protocol RedditListCellDelegate: class {
    func imageTapped(cell: UITableViewCell)
}

class RedditListCell: UITableViewCell {
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var entryDate: UILabel!
    @IBOutlet weak var titleInfo: UILabel!
    @IBOutlet weak var numberOfComments: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    weak var delegate: RedditListCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestures()
    }
    
    
    private func addGestures() {
        thumbnail.isUserInteractionEnabled = true
        let gr = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        thumbnail.addGestureRecognizer(gr)
    }
    
    @objc func imageTapped() {
        delegate?.imageTapped(cell: self)
    }
    
    func updateData(_ childData: ChildData?) {
        if let data = childData {
            authorName.text = data.author
            let dateCreated = Date(timeIntervalSince1970: data.dateCreated)
            entryDate.text = dateCreated.getString()
            
            
            titleInfo.text = data.title
            if data.numberOfComments > 0 {
                numberOfComments.text = "Comments: \(data.numberOfComments)"
            } else {
                numberOfComments.text = ""
            }
            
            loadImage(urlString: data.thumbnailUrl)
        }
    }
    
   
    func loadImage(urlString: String?) {
        self.thumbnail.image = nil
        
        guard let urlStr = urlString,
            let url = URL(string: urlStr) else {return}
        
        DispatchQueue.global(qos: .utility).async {
            ImageLoader.shared.loadImage(url: url, completion: { (img) in
                DispatchQueue.main.async {
                    if let image = img {
                        self.thumbnail.image = image
                    } else {
                        self.thumbnail.image = #imageLiteral(resourceName: "image_not_available")
                    }
                }
            })
        }
    }
    
    
}


