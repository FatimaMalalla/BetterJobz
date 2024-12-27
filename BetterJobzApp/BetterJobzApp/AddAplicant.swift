//
//  AddAplicant.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import UIKit

/// View controller to add a new applicant.
class AddApplicantViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField! // Field for applicant name.
    @IBOutlet weak var emailTextField: UITextField! // Field for applicant email.
    @IBOutlet weak var phoneNumberTextField: UITextField! // Field for applicant phone number.
    @IBOutlet weak var descriptionTextView: UITextView! // Field for applicant description.

    /// Handles the add applicant action when the button is tapped.
    @IBAction func addApplicantButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty,
              let description = descriptionTextView.text, !description.isEmpty else {
            showAlert("Error", "All fields are required.")
            return
        }

        let newApplicant = Applicant(
            name: name,
            email: email,
            phoneNumber: phoneNumber,
            description: description
        )

        ApplicantManager.shared.addApplicant(newApplicant)
        navigationController?.popViewController(animated: true)
    }

    /// Displays an alert with a title and message.
    private func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

