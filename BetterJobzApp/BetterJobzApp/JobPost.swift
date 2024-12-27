//
//  JobPost.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//
import UIKit


class PostJobViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField! // Field for job title.
    @IBOutlet weak var locationTextField: UITextField! // Field for job location.
    @IBOutlet weak var jobTypeTextField: UITextField! // Field for job type.
    @IBOutlet weak var salaryRangeTextField: UITextField! // Field for salary range.
    @IBOutlet weak var requiredSkillTextField: UITextField! // Field for required skills.
    @IBOutlet weak var descriptionTextView: UITextView! // Field for job description.

    /// Handles the post job action when the button is tapped.
    @IBAction func postJobButtonTapped(_ sender: UIButton) {
        // Ensure all required fields are filled.
        guard let title = titleTextField.text, !title.isEmpty,
              let location = locationTextField.text, !location.isEmpty else {
            showAlert("Error", "Title and location are required.")
            return
        }

        // Create a new job object.
        let newJob = Job(
            title: title,
            location: location,
            jobType: jobTypeTextField.text ?? "",
            salaryRange: salaryRangeTextField.text ?? "",
            requiredSkill: requiredSkillTextField.text ?? "",
            description: descriptionTextView.text ?? ""
        )

        // Add the job to the manager and navigate back.
        JobManager.shared.addJob(newJob)
        navigationController?.popViewController(animated: true)
    }

    /// Displays an alert with a title and message.
    private func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
