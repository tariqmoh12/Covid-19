//
//  ArticlesTableViewCell.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

import UIKit
import SDWebImage
class ArticlesTableViewCell: UITableViewCell {
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var publishedAtLabel: UILabel!
    var model : Article!{
        didSet{
            guard let model = model else {
                return
            }
            
            if let imageString = model.urlToImage {
                guard let imageURL = URL(string: imageString) else { return}
                self.articleImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
            }

            articleTitleLabel.text = model.title
            articleDescLabel.text = model.articleDescription
            sourceLabel.text = model.source?.name
            publishedAtLabel.text =   model.publishedAt
            
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .black
        self.articleTitleLabel.textColor = .white
        self.articleDescLabel.textColor = .white
        self.sourceLabel.textColor = .white
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
