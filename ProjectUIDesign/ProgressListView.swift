//
//  ProgressListView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

//import SwiftUI
//
//struct ProgressListView: View {
//    let progresses: [Progress]
//
//    var body: some View {
//        List(progresses) { progress in
//            NavigationLink {
//                    ProgressDetailView(progress: progress)
//            } label: {
//                VStack(alignment: .leading, spacing: 6) {
//                    Text("Week Of: \(progress.weekOf)")
//                        .font(.headline)
//                    
//                    if let grade = progress.currentGradePercent {
//                        Text("Current Grade: \(grade, specifier: "%.0f")%")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//                    
//                    HStack(spacing: 12) {
//                        if let acc = progress.accumulatedPercentPoints {
//                            Text("Accum: \(acc, specifier: "%.0f")")
//                                .font(.caption)
//                                .foregroundColor(.secondary)
//                        }
//                        if let used = progress.usedPercentPoints {
//                            Text("Used: \(used, specifier: "%.0f")")
//                                .font(.caption)
//                                .foregroundColor(.secondary)
//                        }
//                        if let lost = progress.lostPercentPoints {
//                            Text("Lost: \(lost, specifier: "%.0f")")
//                                .font(.caption)
//                                .foregroundColor(.secondary)
//                        }
//                    }
//                    
//                    if let canMeet = progress.canMeetGoal {
//                        Text(canMeet ? "On track to meet goal" : "At risk of missing goal")
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                    }
//                }
//                .padding(.vertical, 6)
//            }
//        }
//        .navigationTitle("Progress")
//    }
//}

//import SwiftUI
//
//struct ProgressListView: View {
//    @EnvironmentObject var store: AppStore
//
//    var body: some View {
//        List(store.progresses) { progress in
//            NavigationLink {
//                ProgressDetailView(progressID: progress.id)
//            } label: {
//                VStack(alignment: .leading, spacing: 6) {
//                    Text("Week Of: \(progress.weekOf)").font(.headline)
//                    if let grade = progress.currentGradePercent {
//                        Text("Current Grade: \(grade, specifier: "%.0f")%")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//                }
//                .padding(.vertical, 6)
//            }
//        }
//        .navigationTitle("Progress")
//    }
//}

import SwiftUI

struct ProgressListView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        List(store.courses) { course in
            let latest = latestProgress(for: course.id)
            
            if let progress = latest {
                NavigationLink {
                    ProgressDetailView(progressID: progress.id)
                } label: {
                    courseRow(course: course, progress: progress)
                }
            } else {
                courseRow(course: course, progress: nil)
            }
        }
        .navigationTitle("Progress")
    }

    // MARK: - Course Row UI
    private func courseRow(course: Course, progress: Progress?) -> some View {
        VStack(alignment: .leading, spacing: 6) {

            Text(course.code)
                .font(.headline)

            Text(course.title)
                .font(.subheadline)
                .foregroundColor(.secondary)

            if let p = progress {

                HStack(spacing: 12) {
                    Text("Accumulated Percentage Points: \(p.accumulatedPercentPoints.whole)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("Current Grade: \(p.currentGradePercent.percent)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                         Text("Max Possible Grade: \(p.maxPossiblePercent.percent)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Text(p.canMeetGoal ? "On track to meet goal"
                                   : "At risk of missing goal")
                    .font(.caption)
                    .foregroundColor(p.canMeetGoal ? .secondary : .red)

            } else {
                Text("No progress calculated yet")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 6)
    }

    // MARK: - Find Latest Progress
    private func latestProgress(for courseID: UUID) -> Progress? {
        store.progresses
            .filter { $0.courseID == courseID }
            .sorted { $0.weekOf > $1.weekOf }   // using weekOf to determine lastest progress
            .first
    }
}


//#Preview {
//    NavigationStack {
//        ProgressListView(progresses: Progress.sampleProgresses)
//    }
//}

#Preview {
    NavigationStack {
        ProgressListView()
    }
    .environmentObject(AppStore())
}

