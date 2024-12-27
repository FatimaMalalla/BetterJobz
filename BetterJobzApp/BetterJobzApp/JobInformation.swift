//
//  JobInformation.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import UIKit

class JobInformationViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var requiredSkillLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    var jobIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadJobInformation()
    }

    private func loadJobInformation() {
        guard let index = jobIndex, index < JobManager.shared.jobs.count else { return }
        let job = JobManager.shared.jobs[index]

        titleLabel.text = job.title
        typeLabel.text = job.type
        locationLabel.text = job.location
        salaryLabel.text = job.salary
        requiredSkillLabel.text = job.requiredSkill
        descriptionTextView.text = job.description
    }
}

