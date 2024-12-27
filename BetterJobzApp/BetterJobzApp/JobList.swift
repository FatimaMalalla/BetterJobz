//
//  JobList.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

//  Created by Macbook Pro on 26/12/2024.
import UIKit

class JobListViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(refreshJobList), name: .jobDataChanged, object: nil)
        refreshJobList()
    }

    @objc private func refreshJobList() {
        // Clear existing views
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Add jobs to the stack view
        for job in JobManager.shared.jobs {
            let jobView = createJobView(for: job)
            stackView.addArrangedSubview(jobView)
        }
    }

    private func createJobView(for job: Job) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.heightAnchor.constraint(equalToConstant: 100).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = job.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        return container
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .jobDataChanged, object: nil)
    }
}

