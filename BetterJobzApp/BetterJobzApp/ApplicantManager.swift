//
//  ApplicantManager.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 28/12/2024.
//

class ApplicantManager {
    static let shared = ApplicantManager()
    
    private init() {}
    
    var applicants: [Applicant] = []
    
    func addApplicant(_ applicant: Applicant) {
        applicants.append(applicant)
    }
    
    func updateApplicant(at index: Int, with updatedApplicant: Applicant) {
        guard applicants.indices.contains(index) else { return }
        applicants[index] = updatedApplicant
    }
    
    func deleteApplicant(at index: Int) {
        guard applicants.indices.contains(index) else { return }
        applicants.remove(at: index)
    }
}

