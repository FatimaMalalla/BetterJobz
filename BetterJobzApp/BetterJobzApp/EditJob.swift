//
//  EditJob.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import UIKit

/// View controller to edit an existing job.
class EditJobViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField! // Field for job title.
    @IBOutlet weak var locationTextField: UITextField! // Field for job location.
    @IBOutlet weak var jobTypeTextField: UITextField! // Field for job type.
    @IBOutlet weak var salaryRangeTextField: UITextField! // Field for salary range.
    @IBOutlet weak var requiredSkillTextField: UITextField! // Field for required skills.
    @IBOutlet weak var descriptionTextView: UITextView! // Field for job description.

    var jobIndex: Int? // Index of the job to be edited.

    override func viewDidLoad() {
        super.viewDidLoad()
        populateFields()
    }

    /// Populates text fields with the current job details.
    private func populateFields() {
        guard let index = jobIndex, index < JobManager.shared.jobs.count else { return }
        let job = JobManager.shared.jobs[index]
        titleTextField.text = job.title
        locationTextField.text = job.location
        jobTypeTextField.text = job.jobType
        salaryRangeTextField.text = job.salaryRange
        requiredSkillTextField.text = job.requiredSkill
        descriptionTextView.text = job.description
    }

    /// Handles the save changes action when the button is tapped.
    @IBAction func saveChangesTapped(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty,
              let location = locationTextField.text, !location.isEmpty,
              let index = jobIndex else {
            showAlert("Error", "All fields are required.")
            return
        }

        let updatedJob = Job(
            title: title,
            location: location,
            jobType: jobTypeTextField.text ?? "",
            salaryRange: salaryRangeTextField.text ?? "",
            requiredSkill: requiredSkillTextField.text ?? "",
            description: descriptionTextView.text ?? ""
        )

        JobManager.shared.updateJob(at: index, with: updatedJob)
        navigationController?.popViewController(animated: true)
    }

    /// Displays an alert with a title and message.
    private func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
