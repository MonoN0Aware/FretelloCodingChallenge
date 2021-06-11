//
//  SessionTableViewCell.swift
//  FretelloTask2
//
//  Created by Decagon on 09/06/2021.
//

import UIKit
import Kingfisher

class SessionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var session: Exercise?
    {
        didSet{
            DispatchQueue.main.async {
                do
                {
                    let url = URL(string: "\(constants.urlStr)\(self.session?.exerciseID ?? "")\(constants.png)")
                    self.exerciseImage.kf.setImage(with: url)
                    self.nameLabel.text = self.session?.name
                    self.exerciseLabel.text = self.session?.name
                    self.bpmLabel.text = "\(self.session?.practicedAtBPM ?? Int())"
                }
            }
        }
    }
    

    
    func convertDateFormat(inputDate: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let oldDate = olDateFormatter.date(from: inputDate)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMM dd yyyy"
        return convertDateFormatter.string(from: oldDate!)
    }
    
}
