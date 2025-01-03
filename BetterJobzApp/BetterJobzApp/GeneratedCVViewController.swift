import UIKit
import PDFKit
import FirebaseAuth
import FirebaseDatabase

class GeneratedCVViewController: UIViewController {

    // Data fetched from Firebase
    var aboutMe: String = ""
    var cvData: [String: Any] = [:]
    var skills: [String] = []
    var interests: [String] = []
    var workExperience: [String] = []

    @IBOutlet weak var cvTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCVData()
    }

    // Fetch CV data from Firebase
    private func fetchCVData() {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users").child(userUID)

        databaseRef.observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            guard let data = snapshot.value as? [String: Any] else {
                self.displayNoData()
                return
            }

            // Extract CV details from Firebase
            self.aboutMe = data["aboutMe"] as? String ?? "N/A"
            self.cvData = data["cv"] as? [String: Any] ?? [:]
            self.skills = data["skills"] as? [String] ?? []
            self.interests = data["interests"] as? [String] ?? []
            self.workExperience = data["workExperience"] as? [String] ?? []

            // Update the CV text view
            DispatchQueue.main.async {
                let formattedCV = self.formatCVContent(
                    aboutMe: self.aboutMe,
                    cvData: self.cvData,
                    skills: self.skills,
                    interests: self.interests,
                    workExperience: self.workExperience
                )
                self.cvTextView.attributedText = formattedCV
                //self.cvTextView.backgroundColor = .black // Background color
                self.cvTextView.textColor = .white       // Text color
            }
        }
    }

    // Display fallback if no data is found
    private func displayNoData() {
        DispatchQueue.main.async {
            self.cvTextView.text = "No CV content available."
            self.cvTextView.textColor = .white
            //self.cvTextView.backgroundColor = .black
        }
    }

    private func formatCVContent(
        aboutMe: String,
        cvData: [String: Any],
        skills: [String],
        interests: [String],
        workExperience: [String]
    ) -> NSAttributedString {
        let fullName = cvData["fullName"] as? String ?? "N/A"
        let email = cvData["email"] as? String ?? "N/A"
        let language = cvData["language"] as? String ?? "N/A"
        let education = cvData["education"] as? String ?? "N/A"
        let occupation = cvData["occupation"] as? String ?? "N/A"
        let phoneNumber = cvData["phoneNumber"] as? String ?? "N/A"

        let boldFont = UIFont.boldSystemFont(ofSize: 16)
        let regularFont = UIFont.systemFont(ofSize: 14)
        let textColor = UIColor.white

        let formattedCV = NSMutableAttributedString()

        // Center-aligned paragraph style
        let centerAlignStyle = NSMutableParagraphStyle()
        centerAlignStyle.alignment = .center

        // Left-aligned paragraph style
        let leftAlignStyle = NSMutableParagraphStyle()
        leftAlignStyle.alignment = .left

        // Title (Center-aligned)
        formattedCV.append(NSAttributedString(
            string: "CV\n\n",
            attributes: [
                .font: boldFont,
                .foregroundColor: textColor,
                .paragraphStyle: centerAlignStyle
            ]
        ))

        // Full Name (Center-aligned)
        formattedCV.append(NSAttributedString(
            string: "\(fullName)\n\n",
            attributes: [
                .font: boldFont,
                .foregroundColor: textColor,
                .paragraphStyle: centerAlignStyle
            ]
        ))
        
        // Contact Information
        formattedCV.append(NSAttributedString(
            string: "Contact Information:\n",
            attributes: [
                .font: boldFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))
        formattedCV.append(NSAttributedString(
            string: "Email: \(email)\nPhone: \(phoneNumber)\n\n",
            attributes: [
                .font: regularFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))

        // About Me Section
        formattedCV.append(NSAttributedString(
            string: "About Me:\n",
            attributes: [
                .font: boldFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(aboutMe)\n\n",
            attributes: [
                .font: regularFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))

        // Skills Section
        formattedCV.append(NSAttributedString(
            string: "Skills:\n",
            attributes: [
                .font: boldFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(skills.joined(separator: ", "))\n\n",
            attributes: [
                .font: regularFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))

        // Interests Section
        formattedCV.append(NSAttributedString(
            string: "Interests:\n",
            attributes: [
                .font: boldFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(interests.joined(separator: ", "))\n\n",
            attributes: [
                .font: regularFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))

        // Language Section
        formattedCV.append(NSAttributedString(
            string: "Language:\n",
            attributes: [
                .font: boldFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(language)\n\n",
            attributes: [
                .font: regularFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))

        // Education Section
        formattedCV.append(NSAttributedString(
            string: "Education:\n",
            attributes: [
                .font: boldFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(education)\n\n",
            attributes: [
                .font: regularFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))

        // Occupation Section
        formattedCV.append(NSAttributedString(
            string: "Occupation:\n",
            attributes: [
                .font: boldFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(occupation)\n\n",
            attributes: [
                .font: regularFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))

      

        // Work Experience Section
        formattedCV.append(NSAttributedString(
            string: "Work Experience:\n",
            attributes: [
                .font: boldFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(workExperience.joined(separator: ", "))\n",
            attributes: [
                .font: regularFont,
                .foregroundColor: textColor,
                .paragraphStyle: leftAlignStyle
            ]
        ))

        return formattedCV
    }


    // MARK: Save as PDF
    @IBAction func saveAsPDFTapped(_ sender: UIButton) {
        generatePDF(cvContent: cvTextView.text)
    }
    @IBAction func saveAsDocTapped(_ sender: UIButton) {
        saveAsDoc(cvContent: cvTextView.text)
    }
    
    // MARK: Save as PDF
    private func generatePDF(cvContent: String) {
        let pdfMetaData = [
            kCGPDFContextCreator: "BetterJobz App",
            kCGPDFContextAuthor: "Generated by BetterJobz"
        ]
        let pdfPageFrame = CGRect(x: 0, y: 0, width: 612, height: 792)
        let pdfData = NSMutableData()

        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, pdfMetaData)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.blue
        ]
        cvContent.draw(
            in: CGRect(x: 20, y: 20, width: pdfPageFrame.width - 40, height: pdfPageFrame.height - 40),
            withAttributes: attributes
        )
        UIGraphicsEndPDFContext()

        let temporaryDirectory = FileManager.default.temporaryDirectory
        let pdfURL = temporaryDirectory.appendingPathComponent("GeneratedCV.pdf")

        do {
            try pdfData.write(to: pdfURL)

            let documentPicker = UIDocumentPickerViewController(forExporting: [pdfURL])
            documentPicker.modalPresentationStyle = .formSheet
            self.present(documentPicker, animated: true, completion: nil)
        } catch {
            showAlert(title: "Error", message: "Failed to generate PDF: \(error.localizedDescription)")
        }
    }

    private func saveAsDoc(cvContent: String) {
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let docURL = temporaryDirectory.appendingPathComponent("GeneratedCV.doc")

        do {
            try cvContent.write(to: docURL, atomically: true, encoding: .utf8)

            let documentPicker = UIDocumentPickerViewController(forExporting: [docURL])
            documentPicker.modalPresentationStyle = .formSheet
            self.present(documentPicker, animated: true, completion: nil)
        } catch {
            showAlert(title: "Error", message: "Failed to save DOC file: \(error.localizedDescription)")
        }
    }


//    // MARK: Save as DOC (Plain Text File)
//    private func saveAsDoc(cvContent: String) {
//        let fileManager = FileManager.default
//        let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let docURL = docsURL.appendingPathComponent("GeneratedCV.doc")
//
//        do {
//            try cvContent.write(to: docURL, atomically: true, encoding: .utf8)
//            showAlert(title: "Success", message: "DOC file saved successfully at \(docURL.path)")
//        } catch {
//            showAlert(title: "Error", message: "Failed to save DOC file: \(error.localizedDescription)")
//        }
//    }

    // Helper Method to Show Alerts
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

