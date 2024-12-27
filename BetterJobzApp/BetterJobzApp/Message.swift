//
//  Message.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import UIKit

class MessageViewController: UIViewController {
    @IBOutlet weak var recipientLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!

    var applicantIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecipientDetails()
    }

    private func loadRecipientDetails() {
        guard let index = applicantIndex,
              let applicant = ApplicantManager.shared.getApplicant(at: index) else { return }
        recipientLabel.text = "Message to: \(applicant.name)"
    }

    @IBAction func sendMessageTapped(_ sender: UIButton) {
        guard let message = messageTextView.text, !message.isEmpty,
              let index = applicantIndex else {
            showAlert(title: "Error", message: "Message cannot be empty.")
            return
        }

        // Add the message to the applicant
        ApplicantManager.shared.addMessage(forApplicantAt: index, message: message)

        // Dismiss the view
        navigationController?.popViewController(animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

