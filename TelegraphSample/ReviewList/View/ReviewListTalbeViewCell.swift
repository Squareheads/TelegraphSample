//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import UIKit
import Kingfisher

final class ReviewListTableViewCell: UITableViewCell {
    enum Constants {
        static let ReuseIdentifier = "ReviewListTableViewCell"
    }

    @IBOutlet var headlineLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var synopsisLabel: UILabel!
    @IBOutlet var pictureImageView: UIImageView!


    override func prepareForReuse() {
        super.prepareForReuse()
        headlineLabel.text = ""
        descriptionLabel.text = ""
        synopsisLabel.text = ""
        pictureImageView.image = nil
        pictureImageView.kf.cancelDownloadTask()
    }
}
