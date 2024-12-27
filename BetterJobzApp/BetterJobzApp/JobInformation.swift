//
//  JobInformation.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import UIKit

/// View controller to display job information.
class JobInformationViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel! // Label for job title.
    @IBOutlet weak var locationLabel: UILabel! // Label for job location.
    @IBOutlet weak var jobTypeLabel: UILabel! // Label for job type.
    @IBOutlet weak var salaryLabel: UILabel! // Label for salary range.
    @IBOutlet weak var requiredSkillLabel: UILabel! // Label for required skills.
    @IBOutlet weak var descriptionTextView: UITextView! // Text view for job description.

    var job: Job? // The job to display details for.

    override func viewDidLoad() {
        super.viewDidLoad()
        displayJobDetails()
    }

    /// Loads job details into UI elements.
    private func displayJobDetails() {
        guard let job = job else { return }
        titleLabel.text = job.title
        locationLabel.text = job.location
        jobTypeLabel.text = job.jobType
        salaryLabel.text = job.salaryRange
        requiredSkillLabel.text = job.requiredSkill
        descriptionTextView.text = job.description
    }
}
