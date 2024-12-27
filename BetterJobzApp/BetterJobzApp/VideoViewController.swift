//
//  VideoViewController.swift
//  BetterJobzApp
//
//  Created by Guest User on 26/12/2024.
//

import UIKit
import FirebaseAuth

class VideoViewController: BaseVideoViewController {

    @IBOutlet weak var firstLikeButton: UIButton!
    @IBOutlet weak var firstSaveButton: UIButton!
    
    @IBOutlet weak var secondLikeButton: UIButton!
    @IBOutlet weak var secondSaveButton: UIButton!
    
    @IBOutlet weak var thirdLikeButton: UIButton!
    @IBOutlet weak var thirdSaveButton: UIButton!

    var isFirstButtonLiked = false
    var isFirstButtonSaved = false
    
    var isSecondButtonLiked = false
    var isSecondButtonSaved = false
    
    var isThirdButtonLiked = false
    var isThirdButtonSaved = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign user ID after login
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        self.userID = userID

        // Fetch and update button states
        fetchButtonStates(likeKey: "likeButtonState", saveKey: "saveButtonState") { [weak self] isLiked, isSaved in
            guard let self = self else { return }
            self.isFirstButtonLiked = isLiked
            self.isFirstButtonSaved = isSaved
            self.updateFirstButtonImages()
        }
        
        // Fetch and update states for the second set of buttons
        fetchButtonStates(likeKey: "secondLikeButtonState", saveKey: "secondSaveButtonState") { [weak self] isLiked, isSaved in
            guard let self = self else { return }
            self.isSecondButtonLiked = isLiked
            self.isSecondButtonSaved = isSaved
            self.updateSecondButtonImages()
        }
        
        fetchButtonStates(likeKey: "thirdLikeButtonState", saveKey: "thirdSaveButtonState") { [weak self] isLiked, isSaved in
            guard let self = self else { return }
            self.isThirdButtonLiked = isLiked
            self.isThirdButtonSaved = isSaved
            self.updateThirdButtonImages()
        }

        // Add a real-time listener
        addRealTimeListener(likeKey: "likeButtonState", saveKey: "saveButtonState") { [weak self] isLiked, isSaved in
            guard let self = self else { return }
            self.isFirstButtonLiked = isLiked
            self.isFirstButtonSaved = isSaved
            self.updateFirstButtonImages()
        }
        
        //Second listener
        addRealTimeListener(likeKey: "secondLikeButtonState", saveKey: "secondSaveButtonState") { [weak self] isLiked, isSaved in
            guard let self = self else { return }
            self.isSecondButtonLiked = isLiked
            self.isSecondButtonSaved = isSaved
            self.updateSecondButtonImages()
        }
        
        addRealTimeListener(likeKey: "thirdLikeButtonState", saveKey: "thirdSaveButtonState") { [weak self] isLiked, isSaved in
            guard let self = self else { return }
            self.isThirdButtonLiked = isLiked
            self.isThirdButtonSaved = isSaved
            self.updateThirdButtonImages()
        }
        
    }

    @IBAction func firstLikeButtonTapped(_ sender: Any) {
        isFirstButtonLiked.toggle()
        saveButtonStates(
            likeKey: "likeButtonState",
            saveKey: "saveButtonState",
            isLiked: isFirstButtonLiked,
            isSaved: isFirstButtonSaved
        )
    }

    @IBAction func firstSaveButtonTapped(_ sender: Any) {
        isFirstButtonSaved.toggle()
        saveButtonStates(
            likeKey: "likeButtonState",
            saveKey: "saveButtonState",
            isLiked: isFirstButtonLiked,
            isSaved: isFirstButtonSaved
        )
    }
    
    // Second Like Button Tapped
    @IBAction func secondLikeButtonTapped(_ sender: Any) {
        isSecondButtonLiked.toggle()
        saveButtonStates(
            likeKey: "secondLikeButtonState",
            saveKey: "secondSaveButtonState",
            isLiked: isSecondButtonLiked,
            isSaved: isSecondButtonSaved
        )
    }

    // Second Save Button Tapped
    @IBAction func secondSaveButtonTapped(_ sender: Any) {
        isSecondButtonSaved.toggle()
        saveButtonStates(
            likeKey: "secondLikeButtonState",
            saveKey: "secondSaveButtonState",
            isLiked: isSecondButtonLiked,
            isSaved: isSecondButtonSaved
        )
    }
    
    @IBAction func thirdLikeButtonTapped(_ sender: Any) {
        isThirdButtonLiked.toggle()
        saveButtonStates(
            likeKey: "ThirdLikeButtonState",
            saveKey: "ThirdSaveButtonState",
            isLiked: isThirdButtonLiked,
            isSaved: isThirdButtonSaved
        )
    }

    @IBAction func thirdSaveButtonTapped(_ sender: Any) {
        isThirdButtonSaved.toggle()
        saveButtonStates(
            likeKey: "ThirdLikeButtonState",
            saveKey: "ThirdSaveButtonState",
            isLiked: isThirdButtonLiked,
            isSaved: isThirdButtonSaved
        )
    }

    // Update images for the first set of buttons
    private func updateFirstButtonImages() {
        firstLikeButton.setImage(UIImage(systemName: isFirstButtonLiked ? "heart.fill" : "heart"), for: .normal)
        firstSaveButton.setImage(UIImage(systemName: isFirstButtonSaved ? "bookmark.fill" : "bookmark"), for: .normal)
    }
    
    // Update images for the second set of buttons
    private func updateSecondButtonImages() {
        secondLikeButton.setImage(UIImage(systemName: isSecondButtonLiked ? "heart.fill" : "heart"), for: .normal)
        secondSaveButton.setImage(UIImage(systemName: isSecondButtonSaved ? "bookmark.fill" : "bookmark"), for: .normal)
    }
    
    private func updateThirdButtonImages() {
        thirdLikeButton.setImage(UIImage(systemName: isThirdButtonLiked ? "heart.fill" : "heart"), for: .normal)
        thirdSaveButton.setImage(UIImage(systemName: isThirdButtonSaved ? "bookmark.fill" : "bookmark"), for: .normal)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func firstVideo(_ sender: Any) {
        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=0FFLFcB9xfQ")!
        
        // Open the URL
        if UIApplication.shared.canOpenURL(youtubeURL) {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL")
        }
    }
    
    @IBAction func secondVideo(_ sender: Any) {
        // Second Video
        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=hrZSfMly_Ck")!
        
        // Open the URL
        if UIApplication.shared.canOpenURL(youtubeURL) {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL")
        }
    }
    
    @IBAction func thirdVideo(_ sender: Any) {
        //Third Video
        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=HG68Ymazo18")!
        
        // Open the URL
        if UIApplication.shared.canOpenURL(youtubeURL) {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
