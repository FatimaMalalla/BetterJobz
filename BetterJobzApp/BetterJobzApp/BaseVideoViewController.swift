//
//  BaseVideoViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-224-14 on 27/12/2024.
//

import UIKit
import Firebase
import FirebaseAuth

class BaseVideoViewController: UIViewController {

    var userID: String = "" // To be dynamically set after login
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    // Generalized method to fetch button states with specific keys
    func fetchButtonStates(likeKey: String, saveKey: String, completion: @escaping (Bool, Bool) -> Void) {
        guard !userID.isEmpty else {
            print("User ID is not set.")
            completion(false, false)
            return
        }

        ref.child("users").child(userID).child("video").observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                let isLiked = data[likeKey] as? Bool ?? false
                let isSaved = data[saveKey] as? Bool ?? false
                completion(isLiked, isSaved)
            } else {
                completion(false, false) // Default states if no data exists
            }
        }
    }

    // Generalized real-time listener for button states
    func addRealTimeListener(likeKey: String, saveKey: String, stateChangeHandler: @escaping (Bool, Bool) -> Void) {
        guard !userID.isEmpty else {
            print("User ID is not set.")
            return
        }

        ref.child("users").child(userID).child("video").observe(.value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                let isLiked = data[likeKey] as? Bool ?? false
                let isSaved = data[saveKey] as? Bool ?? false
                stateChangeHandler(isLiked, isSaved)
            }
        }
    }

    // Generalized method to save button states with specific keys
    func saveButtonStates(likeKey: String, saveKey: String, isLiked: Bool, isSaved: Bool) {
        guard !userID.isEmpty else {
            print("User ID is not set.")
            return
        }

        let buttonStates: [String: Any] = [
            likeKey: isLiked,
            saveKey: isSaved
        ]
        ref.child("users").child(userID).child("video").updateChildValues(buttonStates)
    }
}
