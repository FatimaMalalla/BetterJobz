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

    var applicantIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadApplicantDetails()
    }

    private func loadApplicantDetails() {
        guard let index = applicantIndex,
              let applicant = ApplicantManager.shared.getApplicant(at: index) else { return }

        nameLabel.text = applicant.name
        emailLabel.text = applicant.email
        phoneNumberLabel.text = applicant.phoneNumber
        descriptionTextView.text = applicant.description
    }

    @IBAction func messageButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToMessage", sender: applicantIndex)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMessage",
           let destinationVC = segue.destination as? MessageViewController,
           let applicantIndex = sender as? Int {
            destinationVC.applicantIndex = applicantIndex // Pass the selected applicant's index
        }
    }
}



