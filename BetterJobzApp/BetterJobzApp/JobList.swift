//
//  JobList.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

//  Created by Macbook Pro on 26/12/2024.
import UIKit

/// View controller to display a list of jobs.
class JobListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! // Table view to display jobs.

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() // Reload table view when the view appears.
    }
}

extension JobListViewController: UITableViewDataSource, UITableViewDelegate {
    /// Number of rows in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JobManager.shared.jobs.count
    }

    /// Configures each cell in the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath)
        let job = JobManager.shared.jobs[indexPath.row]
        cell.textLabel?.text = job.title
        cell.detailTextLabel?.text = job.location
        return cell
    }

    /// Handles selection of a job in the table view.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedJob = JobManager.shared.jobs[indexPath.row]
        performSegue(withIdentifier: "goToJobInfo", sender: selectedJob)
    }

    /// Prepares for segue navigation.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToJobInfo",
           let destinationVC = segue.destination as? JobInformationViewController,
           let job = sender as? Job {
            destinationVC.job = job
        }
    }
}
