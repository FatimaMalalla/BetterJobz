//
//  JobCell.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 28/12/2024.
//

import UIKit

class JobCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    static let reuseIdentifier = "JobCell"

    func configure(with job: Job) {
        titleLabel.text = job.title
        locationLabel.text = job.location
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        locationLabel.text = nil
    }
}
