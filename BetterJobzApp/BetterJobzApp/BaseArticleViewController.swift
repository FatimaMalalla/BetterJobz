//
//  BaseArticleViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-14 on 26/12/2024.
//

import UIKit
import Firebase
import FirebaseAuth

class BaseArticleViewController: UIViewController {

    var userID: String = "" // To be dynamically set after login
    var ref: DatabaseReference!
    var buttonStateChangeHandler: ((Bool, Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    // Fetch button states from Firebase for the current user
    func fetchButtonStates(completion: @escaping (Bool, Bool) -> Void) {
        guard !userID.isEmpty else {
            print("User ID is not set.")
            completion(false, false)
            return
        }

        ref.child("users").child(userID).observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                let isLiked = data["likeButtonState"] as? Bool ?? false
                let isSaved = data["saveButtonState"] as? Bool ?? false
                completion(isLiked, isSaved)
            } else {
                completion(false, false) // Default states if no data exists
            }
        }
    }
    
    // Fetch states for the second set of buttons from Firebase
    func fetchSecondButtonStates(completion: @escaping (Bool, Bool) -> Void) {
        guard !userID.isEmpty else {
            print("User ID is not set.")
            completion(false, false)
            return
        }

        ref.child("users").child(userID).observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                let isLiked = data["secondLikeButtonState"] as? Bool ?? false
                let isSaved = data["secondSaveButtonState"] as? Bool ?? false
                completion(isLiked, isSaved)
            } else {
                completion(false, false) // Default states if no data exists
            }
        }
    }

    // Add a real-time listener for button states
    func addRealTimeListener() {
        guard !userID.isEmpty else {
            print("User ID is not set.")
            return
        }

        ref.child("users").child(userID).observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            if let data = snapshot.value as? [String: Any] {
                let isLiked = data["likeButtonState"] as? Bool ?? false
                let isSaved = data["saveButtonState"] as? Bool ?? false
                self.buttonStateChangeHandler?(isLiked, isSaved)
            }
        }
    }
    
    func addSecondRealTimeListener() {
        guard !userID.isEmpty else {
            print("User ID is not set.")
            return
        }

        ref.child("users").child(userID).observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            if let data = snapshot.value as? [String: Any] {
                let isLiked = data["secondLikeButtonState"] as? Bool ?? false
                let isSaved = data["secondSaveButtonState"] as? Bool ?? false
                self.buttonStateChangeHandler?(isLiked, isSaved)
            }
        }
    }

    // Save button states to Firebase for the current user
    func saveButtonStates(isLiked: Bool, isSaved: Bool) {
        guard !userID.isEmpty else {
            print("User ID is not set.")
            return
        }

        let userStates: [String: Any] = [
            "likeButtonState": isLiked,
            "saveButtonState": isSaved
        ]
        ref.child("users").child(userID).updateChildValues(userStates)
    }
    
    // Save states for the second set of buttons to Firebase
    func saveSecondButtonStates(isLiked: Bool, isSaved: Bool) {
        guard !userID.isEmpty else {
            print("User ID is not set.")
            return
        }

        let secondButtonStates: [String: Any] = [
            "secondLikeButtonState": isLiked,
            "secondSaveButtonState": isSaved
        ]
        ref.child("users").child(userID).updateChildValues(secondButtonStates)
    }
}
