//
//  ApplicantDetails.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import UIKit

class ApplicantDetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    var applicantIndex: Int? // Index of the selected applicant in ApplicantManager

    override func viewDidLoad() {
        super.viewDidLoad()
        loadApplicantDetails()
    }

    private func loadApplicantDetails() {
        // Safely retrieve the applicant from ApplicantManager
        guard let index = applicantIndex,
              index < ApplicantManager.shared.applicants.count else {
            showAlert("Error", "Applicant not found.")
            return
        }

        let applicant = ApplicantManager.shared.applicants[index]
        nameLabel.text = applicant.name
        emailLabel.text = applicant.email
        phoneNumberLabel.text = applicant.phoneNumber
        descriptionTextView.text = applicant.description
    }

    @IBAction func messageButtonTapped(_ sender: UIButton) {
        // Navigate to the MessageViewController
        performSegue(withIdentifier: "goToMessage", sender: applicantIndex)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMessage",
           let destinationVC = segue.destination as? MessageViewController,
           let applicantIndex = sender as? Int {
            destinationVC.applicantIndex = applicantIndex // Pass the selected applicant's index
        }
    }

    private func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}



