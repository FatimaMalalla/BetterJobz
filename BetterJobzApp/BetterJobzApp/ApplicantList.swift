//
//  ApplicantList.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import UIKit

/// View controller to display a list of applicants.
class ApplicantListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! // Table view to display applicants.

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() // Reload the table view whenever the view appears.
    }
}

extension ApplicantListViewController: UITableViewDataSource, UITableViewDelegate {
    /// Number of rows in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApplicantManager.shared.applicants.count
    }

    /// Configures each cell in the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicantCell", for: indexPath)
        let applicant = ApplicantManager.shared.applicants[indexPath.row]
        cell.textLabel?.text = applicant.name
        return cell
    }

    /// Handles the selection of an applicant to view details.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedApplicantIndex = indexPath.row
        performSegue(withIdentifier: "goToApplicantDetails", sender: selectedApplicantIndex)
    }

    /// Prepares for segue navigation to applicant details.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToApplicantDetails",
           let destinationVC = segue.destination as? ApplicantDetailsViewController,
           let applicantIndex = sender as? Int {
            destinationVC.applicantIndex = applicantIndex
        }
    }
}

