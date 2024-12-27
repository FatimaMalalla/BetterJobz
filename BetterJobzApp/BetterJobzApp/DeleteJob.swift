//
//  DeleteJob.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import UIKit

class DeleteJobViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshJobStackView), name: .jobDataChanged, object: nil)
        refreshJobStackView()
    }

    @objc private func refreshJobStackView() {
        // Clear existing views
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Add job views to the stack view
        for (index, job) in JobManager.shared.jobs.enumerated() {
            let jobView = createJobView(for: job, at: index)
            stackView.addArrangedSubview(jobView)
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

        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.tag = index
        deleteButton.addTarget(self, action: #selector(deleteJob(_:)), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(titleLabel)
        container.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),

            deleteButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            deleteButton.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        return container
    }

    @objc private func deleteJob(_ sender: UIButton) {
        let index = sender.tag
        guard index < JobManager.shared.jobs.count else { return }

        // Remove the job from JobManager
        JobManager.shared.deleteJob(at: index)

        // Notify other views about the change
        NotificationCenter.default.post(name: .jobDataChanged, object: nil)

        // Refresh the stack view
        refreshJobStackView()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .jobDataChanged, object: nil)
    }
}

