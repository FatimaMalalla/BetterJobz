//
//  AboutViewController.swift
//  BetterJobzApp
//
//  Created by Guest User on 19/12/2024.
//

import UIKit

class AboutViewController: UIViewController {
    
        // MARK: - Outlets

        @IBOutlet weak var textView: UITextView!
        
        @IBOutlet weak var editButton: UIButton!
        // MARK: - Properties
        var isEditingTextView = false
        var savedText: String?
        
        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Load saved text or set default placeholder
            textView.text = savedText ?? "Write something about yourself here..."
            textView.isEditable = false // Start with non-editable
        }
        
        // MARK: - Actions
//    @IBAction func editButtonTapped(_ sender: UIButton) {
//            // Toggle editing state
//            isEditingTextView.toggle()
//            
//            if isEditingTextView {
//                // Enable editing mode
//                textView.isEditable = true
//                textView.becomeFirstResponder() // Show the keyboard
//                editButton.setTitle("Done", for: .normal) // Change button title
//            } else {
//                // Disable editing mode
//                textView.isEditable = false
//                textView.resignFirstResponder() // Dismiss the keyboard
//                editButton.setTitle("Edit", for: .normal) // Change button title
//                
//                // Save the updated text
//                savedText = textView.text
//            }
//        }
        
        // MARK: - Save on Back
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // Save text automatically when navigating back
            savedText = textView.text
        }
    }

}
