//
//  EditJob.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import UIKit

class EditJobViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var requiredSkillTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var stack: UIStackView!

    var job: Job?
    var jobIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        populateFields()
        refreshJobStackView()
    }

    private func populateFields() {
        guard let job = job else { return }
        titleTextField.text = job.title
        typeTextField.text = job.type
        locationTextField.text = job.location
        salaryTextField.text = job.salary
        requiredSkillTextField.text = job.requiredSkill
        descriptionTextView.text = job.description
    }

    @IBAction func saveChangesTapped(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty,
              let type = typeTextField.text, !type.isEmpty,
              let location = locationTextField.text, !location.isEmpty,
              let salary = salaryTextField.text, !salary.isEmpty,
              let requiredSkill = requiredSkillTextField.text, !requiredSkill.isEmpty,
              let description = descriptionTextView.text, !description.isEmpty,
              let index = jobIndex else {
            showAlert(title: "Error", message: "All fields are required!")
            return
        }

        // Update the job in JobManager
        let updatedJob = Job(title: title, type: type, location: location, salary: salary, requiredSkill: requiredSkill, description: description)
        JobManager.shared.updateJob(at: index, with: updatedJob)

        // Notify other views about the update
        NotificationCenter.default.post(name: .jobDataChanged, object: nil)

        // Refresh the stack view to reflect changes locally
        refreshJobStackView()

        // Navigate back to the previous screen
        navigationController?.popViewController(animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func refreshJobStackView() {
        // Clear the stack view
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Add updated job data to the stack view
        for (index, job) in JobManager.shared.jobs.enumerated() {
            let jobView = createJobView(for: job, at: index)
            stack.addArrangedSubview(jobView)
        }
    }

    private func createJobView(for job: Job, at index: Int) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.heightAnchor.constraint(equalToConstant: 100).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = job.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let editButton = UIButton(type: .system)
        editButton.setTitle("Edit", for: .normal)
        editButton.tag = index
        editButton.addTarget(self, action: #selector(editJob(_:)), for: .touchUpInside)
        editButton.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(titleLabel)
        container.addSubview(editButton)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),

            editButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            editButton.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        return container
    }

    @objc private func editJob(_ sender: UIButton) {
        let index = sender.tag
        guard index < JobManager.shared.jobs.count else { return }

        let selectedJob = JobManager.shared.jobs[index]
        job = selectedJob
        jobIndex = index
        populateFields() // Populate the fields with the selected job
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .jobDataChanged, object: nil)
    }
}

