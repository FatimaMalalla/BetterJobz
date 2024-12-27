//
//  JobPost.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import UIKit

class PostJobViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var requiredSkillTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var deadlineTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @IBAction func postJobButtonTapped(_ sender: UIButton) {
        // Validate inputs
        guard let title = titleTextField.text, !title.isEmpty,
              let type = typeTextField.text, !type.isEmpty,
              let location = locationTextField.text, !location.isEmpty,
              let salary = salaryTextField.text, Double(salary) != nil,
              let requiredSkill = requiredSkillTextField.text, !requiredSkill.isEmpty,
              let deadline = deadlineTextField.text, !deadline.isEmpty,
              let description = descriptionTextView.text, !description.isEmpty else {
            showAlert(title: "Error", message: "All fields are required and salary must be numeric!")
            return
        }

        // Create and add new job
        let newJob = Job(title: title, type: type, location: location, salary: salary, requiredSkill: requiredSkill, description: description)
        JobManager.shared.addJob(newJob)

        // Notify other views about the new job
        NotificationCenter.default.post(name: .jobDataChanged, object: nil)

        // Reset fields and show success message
        resetFields()
        showSuccessMessage()
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func showSuccessMessage() {
        let alert = UIAlertController(title: "Success", message: "Job posted successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }

    private func resetFields() {
        titleTextField.text = ""
        typeTextField.text = ""
        locationTextField.text = ""
        salaryTextField.text = ""
        requiredSkillTextField.text = ""
        deadlineTextField.text = ""
        descriptionTextView.text = ""
    }

    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

