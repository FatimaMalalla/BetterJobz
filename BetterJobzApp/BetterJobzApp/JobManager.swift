//
//  JobManager.swift
//  BetterJobzApp
//
//  Created by Macbook Pro on 27/12/2024.
//


class JobManager {
    static let shared = JobManager()
    
    private init() {} // Prevent external instantiation

    var jobs: [Job] = [] // Shared list of jobs

    func addJob(_ job: Job) {
        jobs.append(job)
    }

    func updateJob(at index: Int, with updatedJob: Job) {
        guard jobs.indices.contains(index) else { return }
        jobs[index] = updatedJob
    }

    func deleteJob(at index: Int) {
        guard jobs.indices.contains(index) else { return }
        jobs.remove(at: index)
    }
}
