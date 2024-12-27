//
//  Applicant.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//

import Foundation

// Define the Applicant struct
struct Applicant {
    var name: String
    var email: String
    var phoneNumber: String
    var description: String
    var messages: [String] = []
}

// Define the ApplicantManager class as a singleton
class ApplicantManager {
    // Static shared instance
    static let shared = ApplicantManager()
    
    // Private initializer to prevent external instantiation
    private init() {}
    
    // Array to store applicants
    private(set) var applicants: [Applicant] = []
    
    // Method to add a new applicant
    func addApplicant(_ applicant: Applicant) {
        applicants.append(applicant)
    }
    
    // Method to retrieve an applicant by index
    func getApplicant(at index: Int) -> Applicant? {
        guard applicants.indices.contains(index) else { return nil }
        return applicants[index]
    }
    
    // Method to add a message to an applicant
    func addMessage(forApplicantAt index: Int, message: String) {
        guard applicants.indices.contains(index) else { return }
        applicants[index].messages.append(message)
    }
    
    // Method to update an existing applicant
    func updateApplicant(at index: Int, with updatedApplicant: Applicant) {
        guard applicants.indices.contains(index) else { return }
        applicants[index] = updatedApplicant
    }
    
    // Method to delete an applicant
    func deleteApplicant(at index: Int) {
        guard applicants.indices.contains(index) else { return }
        applicants.remove(at: index)
    }
}
