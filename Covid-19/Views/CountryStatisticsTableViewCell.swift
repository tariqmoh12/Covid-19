//
//  CountryStatisticsTableViewCell.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/11/22.
//

import UIKit

class CountryStatisticsTableViewCell: UITableViewCell {
    @IBOutlet weak var caseTitleLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    var model : Country!{
        didSet{
            guard let model = model else {
                return
            }
//            caseTitleLabel.text = model.todayNewOpenCases
//            valueLabel.text = model.yesterdayDeaths
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
