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
    //var buttonStateChangeHandler: ((Bool, Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    // Fetch button states from Firebase for the current user
    func fetchButtonStates(likeKey: String, saveKey: String, completion: @escaping (Bool, Bool) -> Void) {
        guard !userID.isEmpty else {
            print("User ID is not set.")
            completion(false, false)
            return
        }

        ref.child("users").child(userID).child("article").observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                let isLiked = data[likeKey] as? Bool ?? false
                let isSaved = data[saveKey] as? Bool ?? false
                completion(isLiked, isSaved)
            } else {
                completion(false, false) // Default states if no data exists
            }
        }
    }
    
    func addRealTimeListener(likeKey: String, saveKey: String, stateChangeHandler: @escaping (Bool, Bool) -> Void) {
        guard !userID.isEmpty else {
            print("User ID is not set.")
            return
        }

        ref.child("users").child(userID).child("article").observe(.value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                let isLiked = data[likeKey] as? Bool ?? false
                let isSaved = data[saveKey] as? Bool ?? false
                stateChangeHandler(isLiked, isSaved)
            }
        }
    }

    // Save button states to Firebase for the current user
    func saveButtonStates(likeKey: String, saveKey: String, isLiked: Bool, isSaved: Bool) {
        guard !userID.isEmpty else {
            print("User ID is not set.")
            return
        }

        let buttonStates: [String: Any] = [
            likeKey: isLiked,
            saveKey: isSaved
        ]
        ref.child("users").child(userID).child("article").updateChildValues(buttonStates)
    }
}
