//
//  Message.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import UIKit

/// View controller to display applicant's name and show a confirmation message.
class MessageViewController: UIViewController {
    @IBOutlet weak var recipientLabel: UILabel! // Label to display recipient's name.

    var applicantIndex: Int? // Index of the recipient applicant.

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecipientDetails()
    }

    /// Loads the recipient details into the label.
    private func loadRecipientDetails() {
        guard let index = applicantIndex,
              index < ApplicantManager.shared.applicants.count else {
            recipientLabel.text = "Unknown Recipient"
            return
        }

        let applicant = ApplicantManager.shared.applicants[index]
        recipientLabel.text = "Message to: \(applicant.name)"
    }

    /// Handles the button tap to show a confirmation message.
    @IBAction func sendMessageButtonTapped(_ sender: UIButton) {
        showAlert("Message Sent", "Your message has been sent successfully to \(recipientLabel.text ?? "the applicant").")
    }

    /// Displays an alert with a confirmation message.
    private func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
}

