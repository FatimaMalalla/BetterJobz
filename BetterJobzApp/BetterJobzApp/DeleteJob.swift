//
//  DeleteJob.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import UIKit

/// View controller to delete jobs from the list.
class DeleteJobViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! // Table view to display jobs.

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() // Reload the table view whenever the view appears.
    }
}

extension DeleteJobViewController: UITableViewDataSource, UITableViewDelegate {
    /// Number of rows in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JobManager.shared.jobs.count
    }

    /// Configures each cell in the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Match the identifier set in the storyboard.
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteJobCell", for: indexPath)
        let job = JobManager.shared.jobs[indexPath.row]
        cell.textLabel?.text = job.title // Display the job title.
        return cell
    }

    /// Handles the selection of a job to delete.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Delete the job from the manager.
        JobManager.shared.deleteJob(at: indexPath.row)

        // Reload the table view to reflect the changes.
        tableView.reloadData()
    }
}

